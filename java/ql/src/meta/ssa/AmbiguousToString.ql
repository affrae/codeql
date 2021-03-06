/**
 * @name An SSA variable without a unique 'toString()'
 * @description An ambiguous 'toString()' indicates overlap in the defining
 *              sub-classes of 'SsaVariable'.
 * @kind problem
 * @problem.severity error
 * @id java/sanity/non-unique-ssa-tostring
 * @tags sanity
 */

import java
import semmle.code.java.dataflow.SSA

predicate noToString(SsaVariable v) { not exists(v.toString()) }

predicate multipleToString(SsaVariable v) { 1 < count(v.toString()) }

from SsaVariable ssa, ControlFlowNode n, Variable v, string problem
where
  (
    noToString(ssa) and problem = "SSA variable without 'toString()' for "
    or
    multipleToString(ssa) and problem = "SSA variable with multiple 'toString()' results for "
  ) and
  n = ssa.getCFGNode() and
  v = ssa.getSourceVariable().getVariable()
select n, problem + v
