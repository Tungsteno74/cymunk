cdef extern from "chipmunk/chipmunk.h":
    
    void     cpConstraintDestroy (cpConstraint *constraint)
    void     cpConstraintFree (cpConstraint *constraint)
    
    inline cpFloat cpConstraintGetImpulse(cpConstraint *constraint)
    
    # Callback function type that gets called before solving a joint.
    ctypedef void(* cpConstraintPreSolveFunc )(cpConstraint *constraint, cpSpace *space)
    
    # Callback function type that gets called after solving a joint. 
    ctypedef void(* cpConstraintPostSolveFunc )(cpConstraint *constraint, cpSpace *space) 
    
    ctypedef struct cpConstraint:
        cpBody *     a
        cpBody *     b 
        cpFloat     maxForce
        cpFloat     errorBias
        cpFloat     maxBias
        cpConstraintPreSolveFunc preSolve
        cpConstraintPostSolveFunc postSolve
        cpDataPointer     data

    ctypedef struct cpPivotJoint:
        cpConstraint constraint
        cpVect anchr1
        cpVect anchr2

    ctypedef struct cpSlideJoint:
        cpConstraint constraint
        cpVect anchr1
        cpVect anchr2
        cpFloat min
        cpFloat max

    cpConstraint* cpPivotJointNew(cpBody *a, cpBody *b, cpVect pivot)
    cpConstraint* cpPivotJointNew2(cpBody *a, cpBody *b, cpVect anchr1, cpVect anchr2)
    cpConstraint* cpSlideJointNew(cpBody *a, cpBody *b, cpVect anchr1, cpVect anchr2, cpFloat min, cpFloat max)


cdef class Constraint:
    cdef cpConstraint *_constraint
    cdef object _a
    cdef object _b
    cdef int automanaged

cdef class PivotJoint(Constraint):
    cdef cpPivotJoint *_pivotjoint
    cdef tuple anchor1
    cdef tuple anchor2

cdef class SlideJoint(Constraint):
    cdef cpSlideJoint *_slidejoint
    cdef tuple anchor1
    cdef tuple anchor2
    cdef float min
    cdef float max