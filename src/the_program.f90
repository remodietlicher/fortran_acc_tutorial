PROGRAM the_program

    CALL class_test

END PROGRAM the_program

SUBROUTINE class_test

    USE mo_constants, ONLY: n
    USE the_class, ONLY: base

    TYPE(base) :: obj
    INTEGER :: tmp(n), i, j

    CALL obj%alloc

    obj%member1(:) = 0.0
    obj%member2(:) = 1.0

    !$acc update device(obj%member1, obj%member2) async
    !$acc data create(tmp)

    TIME_LOOP: DO i=1,10
        !$acc parallel default(present) async
        !$acc loop gang vector
        DO j=1,n
            tmp(j) = obj%member2(j)
            obj%member2(j) = obj%member1(j) + obj%member2(j)
            obj%member1(j) = tmp(j)
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

