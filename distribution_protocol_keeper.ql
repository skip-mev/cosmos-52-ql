/**
 * @name Missing required protocolpool module
 * @description When using the distribution module, the protocolpool module must also be included
 * @kind problem
 * @problem.severity error
 * @precision high
 * @id go/missing-protocolpool-module
 * @tags correctness
 *       modules
 *       cosmos-sdk
 */
import go

from FuncDecl f
where
  exists (
    CallExpr distrCall |
    distrCall.getTarget().(Function).getName() = "NewAppModule" and
    distrCall.getTarget().(Function).getPackage().getName() = "distribution" and
    distrCall.getEnclosingFunction() = f
  ) and
  not exists (
    CallExpr poolProtocolCall |
    poolProtocolCall.getTarget().(Function).getName() = "NewAppModule" and
    poolProtocolCall.getTarget().(Function).getPackage().getName() = "protocolpool" and
    poolProtocolCall.getEnclosingFunction() = f
  )
select
 f, "In v0.52, if you use the x/distribution module, you must also use the x/protocolpool module"