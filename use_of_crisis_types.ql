/**
 * @name Deprecated x/crisis module types
 * @description In SDK v0.52, the x/crisis module was deprecated
 * @kind problem
 * @problem.severity error
 * @precision high
 * @id go/deprecated-crisis-types
 * @tags correctness
 *       app
 *       cosmos-sdk
 */
import go

/**
 * Predicate to check if a type originates from the x/crisis module or its subpackages.
 */
predicate isCrisisType(Type t) {
  exists(Package p |
    t.getPackage() = p and
    (
      p.getPath() = "github.com/cosmos/cosmos-sdk/x/crisis" or
      p.getPath().matches("github.com/cosmos/cosmos-sdk/x/crisis/%")
    )
  )
}

from TypeExpr te
where
  isCrisisType(te.getType())
select te.getLocation(), "Usage of a type from the deprecated x/crisis module."
