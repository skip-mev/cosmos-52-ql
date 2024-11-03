/**
 * @name Client context should have Bech32 settings
 * @description In SDK v0.52, the client package now utilizes the Context to derive addresses. Your Context does not contain the valid settings
 * @kind problem
 * @problem.severity error
 * @precision high
 * @id go/no-context-bech32-settings
 * @tags correctness
 *       modules
 *       cosmos-sdk
 */
import go

class ContextTracking extends DataFlow::Configuration {
  ContextTracking() { this = "ContextTracking" }
  
  override predicate isSource(DataFlow::Node source) {
    source.getType().getPackage().getPath() = "github.com/cosmos/cosmos-sdk/client" and
    source.getType().getName() = "Context" and
    source.asExpr() instanceof CompositeLit
  }
  
  override predicate isSink(DataFlow::Node sink) {
    exists(CallExpr call |
      call.getTarget().(Method).getName() = "WithAddressCodec"
    ) 
    and exists(CallExpr call |
      call.getTarget().(Method).getName() = "WithValidatorAddressCodec"
    ) 
    and exists(CallExpr call |
      call.getTarget().(Method).getName() = "WithConsensusAddressCodec"
    ) 
    and exists(CallExpr call |
      call.getTarget().(Method).getName() = "WithAddressPrefix"
    ) 
    and exists(CallExpr call |
      call.getTarget().(Method).getName() = "WithValidatorPrefix"
    ) 
  }

  override predicate isAdditionalFlowStep(DataFlow::Node pred, DataFlow::Node succ) {
    exists(CallExpr call |
      // Track through method calls where one WithXXX leads to another
      call.getTarget().(Method).getReceiver().getType().getName() = "Context" and
      pred = DataFlow::receiverNode(call.getTarget().(Method).getReceiver()) and
      succ.asExpr() = call
    )
  }
}

from DataFlow::Node source
where
  source.getType().getPackage().getPath() = "github.com/cosmos/cosmos-sdk/client" and
  source.getType().getName() = "Context" and
  source.asExpr() instanceof CompositeLit and
  not exists(DataFlow::Node sink |
    any(ContextTracking config).hasFlow(source, sink)
  )
select
  source,
  "Found a client.Context instance without a With{AddressCodec/ValidatorAddressCodec/ConsensusAddressCodec/AddressPrefix/ValidatorPrefix} call"