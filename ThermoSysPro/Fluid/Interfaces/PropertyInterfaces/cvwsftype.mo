within ThermoSysPro.Fluid.Interfaces.PropertyInterfaces;
function cvwsftype "Converts water/steam fluid type into fluid type"
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.WaterSteamFluidType;

  input WaterSteamFluidType wsftype;
  output FluidType ftype;

algorithm

  assert((wsftype == WaterSteamFluidType.WaterSteam) or (wsftype == WaterSteamFluidType.WaterSteamSimple) or (wsftype == WaterSteamFluidType.CoolPropMedium), "cvwsftype: wrong fluid type");

  if wsftype == WaterSteamFluidType.WaterSteam then
    ftype :=FluidType.WaterSteam;
  elseif wsftype == WaterSteamFluidType.WaterSteamSimple then
    ftype :=FluidType.WaterSteamSimple;
  elseif wsftype == WaterSteamFluidType.CoolPropMedium then
    ftype :=FluidType.CoolPropMedium;
  else
    assert(true,"cvwsftype: wrong fluid type in if-loop");
  end if;

  annotation (Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
end cvwsftype;
