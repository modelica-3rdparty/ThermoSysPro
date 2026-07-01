within ThermoSysPro.Fluid.Interfaces.PropertyInterfaces;

function cvfgftype "Converts flue gases fluid type into fluid type"
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FlueGasesFluidType;
  input FlueGasesFluidType fgftype;
  output FluidType ftype;
algorithm
  assert(fgftype == FlueGasesFluidType.FlueGases, "cvfgftype: wrong fluid type");
  ftype := FluidType.FlueGases;
  annotation(
    Documentation(info = "
## Copyright © EDF 2002 - 2026   
## ThermoSysPro Version 4.2   
    "));
end cvfgftype;