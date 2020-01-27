MODULE the_class

USE mo_constants, ONLY: n

IMPLICIT NONE

TYPE base
    INTEGER, ALLOCATABLE :: member1(:)
    INTEGER, ALLOCATABLE :: member2(:)
    CONTAINS
        PROCEDURE :: alloc => my_alloc
        PROCEDURE :: dealloc => my_dealloc
END TYPE base

CONTAINS

SUBROUTINE my_alloc(this)
    CLASS(base), INTENT(INOUT) :: this

    INTEGER :: i

    ALLOCATE(this%member1(n))
    ALLOCATE(this%member2(n))

END SUBROUTINE my_alloc

SUBROUTINE my_dealloc(this)
    CLASS(base), INTENT(INOUT) :: this

    INTEGER :: i

    DEALLOCATE(this%member1)
    DEALLOCATE(this%member2)

END SUBROUTINE my_dealloc

END MODULE the_class

