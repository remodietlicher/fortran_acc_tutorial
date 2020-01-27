PROGRAM the_program

    CALL class_test

END PROGRAM the_program

SUBROUTINE class_test

    USE mo_constants, ONLY: n
    USE the_class, ONLY: base

    TYPE(base) :: obj
    INTEGER :: tmp(n)

    CALL obj%alloc

    obj%member1(:) = 0.0
    obj%member2(:) = 1.0

    TIME_LOOP: DO i=1,10
        tmp(:) = obj%member2(:)
        obj%member2(:) = obj%member1(:) + obj%member2(:)
        obj%member1(:) = tmp(:)
    ENDDO TIME_LOOP

    IF(obj%member1(1) == 55) THEN
        PRINT *, "CLASS TEST The result is correct: 55"
    ELSE
        PRINT *, "CLASS TEST Wrong result: ", obj%member1(1), ". Should be 55"
    ENDIF

    CALL obj%dealloc
    

END SUBROUTINE class_test

