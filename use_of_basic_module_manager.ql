/**
 * @name Deprecated BasicModuleManager
 * @description SDK v0.52 deprecated the BasicModuleManager. You should use the ModuleManager instead.
 * @kind problem
 * @problem.severity error
 * @precision high
 * @id go/deprecated-basic-module-manager
 * @tags correctness
 *       app
 *       cosmos-sdk
 */
import go

from TypeExpr te
where
  te.getType().getName() = "BasicManager" and te.getType().getPackage().getPath() = "github.com/cosmos/cosmos-sdk/types/module"
select te, "BasicManager is deprecated in v0.52 - use the ModuleManager instead."
