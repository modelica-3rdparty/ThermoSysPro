within ThermoSysPro.Properties.ModelicaMedia.Functions;
block ThermoProperties_ps_ModelicaMedia
  import ThermoSysPro.Units;
  input Units.SI.AbsolutePressure P "Pressure";
  input Units.SI.SpecificEntropy s "Specific enthalpy";

  output ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ps pro;

  Medium_CoolProp.ThermodynamicState state = Medium_CoolProp.setState_ps(p=P, s=s, phase=0);
  Medium_CoolProp.SaturationProperties sat = Medium_CoolProp.setSat_p(P);

replaceable package Medium_CoolProp =
      ThermoSysPro.Properties.ModelicaMedia.Media.ModelicaMedium "Modelica Medium" annotation(Evaluate=true, Dialog(tab="Fluid", group="CoolProp properties (enable if FluidType.CoolPropMedium)",enable=(ftype == FluidType.CoolPropMedium)));
// replaceable package Medium_CoolProp =
//       ThermoSysPro.Properties.ModelicaMedia.Media.CoolPropMedium                                 "CoolProp Medium" annotation(Evaluate=true, Dialog(tab="Fluid", group="CoolProp properties (enable if FluidType.CoolPropMedium)",enable=(ftype == FluidType.CoolPropMedium)));

equation
  pro.cp = Medium_CoolProp.specificHeatCapacityCp(state);
  pro.d = state.d;
  pro.T = state.T;
  pro.ddsp = -Modelica.Constants.inf;
  pro.ddps = -Modelica.Constants.inf;
  pro.h = Medium_CoolProp.specificEnthalpy(state);
  pro.u = Medium_CoolProp.specificInternalEnergy(state);

    if noEvent((Medium_CoolProp.bubbleEnthalpy(sat)-Medium_CoolProp.dewEnthalpy(sat)) > Modelica.Constants.eps) then // from ThermoSysPro.Properties.WaterSteam.Common.water_ph_r4
    if noEvent(pro.h<Medium_CoolProp.bubbleEnthalpy(sat)) then
      pro.x = 0;
    elseif noEvent(Medium_CoolProp.bubbleEnthalpy(sat)<pro.h and pro.h<Medium_CoolProp.dewEnthalpy(sat)) then
      pro.x=(pro.h - Medium_CoolProp.bubbleEnthalpy(sat))/(Medium_CoolProp.dewEnthalpy(sat) - Medium_CoolProp.bubbleEnthalpy(sat));  // from ThermoSysPro.Properties.WaterSteam.Common.water_ph_r4
    else
      pro.x = 1;
    end if;
  else
    pro.x = 1;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ThermoProperties_ps_ModelicaMedia;
