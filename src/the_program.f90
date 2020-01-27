PROGRAM the_program

    CALL class_test

END PROGRAM the_program

SUBROUTINE class_test

    USE mo_constants, ONLY: n
    USE the_class, ONLY: base

    TYPE(base) :: obj
    INTEGER :: tmp(n), i

    CALL obj%alloc

    obj%member1(:) = 0.0
    obj%member2(:) = 1.0

    !$acc update device(obj%member1, obj%member2) async
    !$acc data create(tmp)

    TIME_LOOP: DO i=1,10
        !$acc parallel default(present) async
        !$acc loop gang vector
        DO i=1,n
            tmp(i) = obj%member2(i)
            obj%member2(i) = obj%member1(i) + obj%member2(i)
            obj%member1(i) = tmp(i)
        ENDDO
        !$acc end parallel
    ENDDO TIME_LOOP

    !$acc update host(obj%member1) async
    !$acc wait
    !$acc end data

    IF(obj%member1(1) == 55) THEN
        PRINT *, "CLASS TEST The result is correct: 55"
    ELSE
        PRINT *, "CLASS TEST Wrong result: ", obj%member1(1), ". Should be 55"
    ENDIF

    CALL obj%dealloc
    

END SUBROUTINE class_test

