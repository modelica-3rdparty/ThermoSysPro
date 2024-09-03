within ThermoSysPro.Properties.ModelicaMedia.Functions;
block ThermoProperties_ph_ModelicaMedia
  import ThermoSysPro.Units;
  input Units.SI.AbsolutePressure P "Pressure";
  input Units.SI.SpecificEnthalpy h "Specific enthalpy";

  output ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro;

  Medium_CoolProp.ThermodynamicState state = Medium_CoolProp.setState_ph(P, h, 0);
  Medium_CoolProp.SaturationProperties sat = Medium_CoolProp.setSat_p(P);

replaceable package Medium_CoolProp =
      ThermoSysPro.Properties.ModelicaMedia.Media.ModelicaMedium "Modelica Medium" annotation(Evaluate=true);
// replaceable package Medium_CoolProp =
//       ThermoSysPro.Properties.ModelicaMedia.Media.CoolPropMedium                                 "CoolProp Medium" annotation(Evaluate=true, Dialog(tab="Fluid", group="CoolProp properties (enable if FluidType.CoolPropMedium)",enable=(ftype == FluidType.CoolPropMedium)));

equation
  pro.cp = Medium_CoolProp.specificHeatCapacityCp(state);
  pro.d = state.d;
  pro.T = state.T;
  pro.ddph = Medium_CoolProp.density_derp_h(state);
  pro.ddhp = Medium_CoolProp.density_derh_p(state);
  pro.s = Medium_CoolProp.specificEntropy(state);
  pro.u = Medium_CoolProp.specificInternalEnergy(state);
  pro.duhp = -Modelica.Constants.inf;
  pro.duph = -Modelica.Constants.inf;

    if noEvent((Medium_CoolProp.bubbleEnthalpy(sat)-Medium_CoolProp.dewEnthalpy(sat)) > Modelica.Constants.eps) then // from ThermoSysPro.Properties.WaterSteam.Common.water_ph_r4
    if noEvent(h<Medium_CoolProp.bubbleEnthalpy(sat)) then
      pro.x = 0;
    elseif noEvent(Medium_CoolProp.bubbleEnthalpy(sat)<h and h<Medium_CoolProp.dewEnthalpy(sat)) then
      pro.x=(h - Medium_CoolProp.bubbleEnthalpy(sat))/(Medium_CoolProp.dewEnthalpy(sat) - Medium_CoolProp.bubbleEnthalpy(sat));  // from ThermoSysPro.Properties.WaterSteam.Common.water_ph_r4
    else
      pro.x = 1;
    end if;
  else
    pro.x = 1;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ThermoProperties_ph_ModelicaMedia;
