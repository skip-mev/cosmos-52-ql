/**
 * @name Module proto calls should use the new Registrar interfaces
 * @description In SDK v0.52, the RegisterInterfaces/RegisterLegacyAminoCodec have changed function signatures to use other types
 * @kind problem
 * @problem.severity error
 * @precision high
 * @id go/bad-proto-interfaces
 * @tags correctness
 *       modules
 *       cosmos-sdk
 */
import go

from Type t, Method m
where
  (m = t.getMethod("RegisterInterfaces") and
  m.getParameter(0).getType().getName() = "InterfaceRegistry") or
  (m = t.getMethod("RegisterLegacyAminoCodec") and
  m.getParameter(0).getType().(PointerType).getBaseType().getName() = "LegacyAmino")
select
  m, "RegisterInterfaces and RegisterLegacyAminoCodec have changed function signatures. Please change the parameters to InterfaceRegistrar/AminoRegistrar"