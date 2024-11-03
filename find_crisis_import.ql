/**
 * @name Deprecated x/crisis import
 * @description The x/crisis module was deprecated in Cosmos SDK v0.52
 * @kind problem
 * @problem.severity error
 * @precision high
 * @id go/deprecated-crisis-module
 * @tags correctness
 *       app
 *       cosmos-sdk
 */
import go

predicate isCrisisImport(ImportSpec importSpec) {
  importSpec.getPath() = "github.com/cosmos/cosmos-sdk/x/crisis" or importSpec.getPath().matches("github.com/cosmos/cosmos-sdk/x/crisis/%")
}

from ImportSpec imp
where
  isCrisisImport(imp)
select imp, "The x/crisis module is deprecated in v0.52"