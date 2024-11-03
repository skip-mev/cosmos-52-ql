/**
 * @name Wrong Context in InitGenesis/ExportGenesis
 * @description SDK v0.52 changed the function signature of InitGenesis and ExportGenesis functions
 * @kind problem
 * @problem.severity error
 * @precision high
 * @id go/wrong-genesis-context
 * @tags correctness
 *       modules
 *       cosmos-sdk
 */
import go

predicate isSDKContext(Parameter context) {
  context.getType().getName() = "Context" and
  context.getType().getPackage().getPath() = "github.com/cosmos/cosmos-sdk/types"
}

from Type t, Method m
where
  (m = t.getMethod("InitGenesis") or m = t.getMethod("ExportGenesis")) and 
  isSDKContext(m.getParameter(0))
select m, "InitGenesis and ExportGenesis in AppModule have changed function signature. Please change them to use context.Context."