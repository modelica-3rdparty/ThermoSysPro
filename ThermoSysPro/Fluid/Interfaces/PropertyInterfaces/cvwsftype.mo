within ThermoSysPro.Fluid.Interfaces.PropertyInterfaces;

function cvwsftype "Converts water/steam fluid type into fluid type"
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.WaterSteamFluidType;
  input WaterSteamFluidType wsftype;
  output FluidType ftype;
algorithm
  assert((wsftype == WaterSteamFluidType.WaterSteam) or (wsftype == WaterSteamFluidType.WaterSteamSimple), "cvwsftype: wrong fluid type");
  ftype := if wsftype == WaterSteamFluidType.WaterSteam then FluidType.WaterSteam else FluidType.WaterSteamSimple;
  annotation(
    Documentation(info = "
## Copyright © EDF 2002 - 2026   
## ThermoSysPro Version 4.2   
    "));
end cvwsftype;