MODULE the_class

USE mo_constants, ONLY: n

IMPLICIT NONE

TYPE base
    INTEGER, POINTER :: member1(:)
    INTEGER, POINTER :: member2(:)
    CONTAINS
        PROCEDURE :: alloc => initialize
        PROCEDURE :: dealloc => finalize
END TYPE base

CONTAINS

SUBROUTINE initialize(this)
    CLASS(base), INTENT(INOUT) :: this

    INTEGER :: i

    ALLOCATE(this%member1(n))
    ALLOCATE(this%member2(n))
    !$acc enter data create(this)
    !$acc enter data create(this%member1)
    !$acc enter data create(this%member2)

END SUBROUTINE initialize

SUBROUTINE finalize(this)
    CLASS(base), INTENT(INOUT) :: this

    INTEGER :: i

    !$acc exit data delete(this%member1)
    !$acc exit data delete(this%member2)
    !$acc exit data delete(this)
    DEALLOCATE(this%member1)
    DEALLOCATE(this%member2)

END SUBROUTINE finalize

END MODULE the_class

