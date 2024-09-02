within ThermoSysPro.Properties.ModelicaMedia.Functions;
block ThermoProperties_ph_ModelicaMedia
  import ThermoSysPro.Units;
  input Units.SI.AbsolutePressure P "Pressure";
  input Units.SI.SpecificEnthalpy h "Specific enthalpy";

  output ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro;

  Medium_CoolProp.ThermodynamicState state=Medium_CoolProp.setState_ph(p=P, h=h, phase=0);
  Medium_CoolProp.SaturationProperties sat = Medium_CoolProp.setSat_p(P);

replaceable package Medium_CoolProp = ThermoSysPro.Properties.CoolPropMedium "CoolProp Medium" annotation(Evaluate=true, Dialog(tab="Fluid", group="CoolProp properties (enable if FluidType.CoolPropMedium)",enable=(ftype == FluidType.CoolPropMedium)));

equation
  pro.cp = state.cp;
  pro.d = state.d;
  pro.T = state.T;
  pro.ddph = state.ddph;
  pro.ddhp = state.ddhp;
  pro.s = state.s;
  pro.u = -Modelica.Constants.inf;
  pro.duhp = -Modelica.Constants.inf;
  pro.duph = -Modelica.Constants.inf;

  if sat.hl<>sat.hv then // from ThermoSysPro.Properties.WaterSteam.Common.water_ph_r4
    if h<sat.hl then
      pro.x = 0;
    elseif (sat.hl<h and h<sat.hv) then
      pro.x=(h - sat.hl)/(sat.hv - sat.hl);  // from ThermoSysPro.Properties.WaterSteam.Common.water_ph_r4
    else
      pro.x = 1;
    end if;
  else
    pro.x = 1;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ThermoProperties_ph_ModelicaMedia;
