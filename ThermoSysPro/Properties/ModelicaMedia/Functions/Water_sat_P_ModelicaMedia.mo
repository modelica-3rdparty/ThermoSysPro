within ThermoSysPro.Properties.ModelicaMedia.Functions;
block Water_sat_P_ModelicaMedia
  import ThermoSysPro.Units;
  input Units.SI.AbsolutePressure P "Pressure";

  output ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat vsat;
  output ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat lsat;

  Medium_CoolProp.SaturationProperties sat = Medium_CoolProp.setSat_p(P);
  Medium_CoolProp.ThermodynamicState state_l;
  Medium_CoolProp.ThermodynamicState state_v;

replaceable package Medium_CoolProp =
      ThermoSysPro.Properties.ModelicaMedia.Media.ModelicaMedium "Modelica Medium" annotation(Evaluate=true, Dialog(tab="Fluid", group="CoolProp properties (enable if FluidType.CoolPropMedium)",enable=(ftype == FluidType.CoolPropMedium)));
// replaceable package Medium_CoolProp =
//       ThermoSysPro.Properties.ModelicaMedia.Media.CoolPropMedium "CoolProp Medium" annotation(Evaluate=true, Dialog(tab="Fluid", group="CoolProp properties (enable if FluidType.CoolPropMedium)",enable=(ftype == FluidType.CoolPropMedium)));

equation
  state_l=Medium_CoolProp.setState_ph(p=P, h=Medium_CoolProp.bubbleEnthalpy(sat), phase=0);
  state_v=Medium_CoolProp.setState_ph(p=P, h=Medium_CoolProp.dewEnthalpy(sat), phase=0);

  vsat.P=P "Pressure";
  vsat.T=state_v.T "Temperature";
  vsat.rho=state_v.d "Density";
  vsat.h=state_v.h "Specific enthalpy";
  vsat.cp=Medium_CoolProp.specificHeatCapacityCp(state_v);
  vsat.pt=-Modelica.Constants.inf "Derivative of pressure wrt. temperature";
  vsat.cv=Medium_CoolProp.specificHeatCapacityCv(state_v);

  lsat.P=P "Pressure";
  lsat.T=state_v.T "Temperature";
  lsat.rho=state_v.d "Density";
  lsat.h=state_v.h "Specific enthalpy";
  lsat.cp=Medium_CoolProp.specificHeatCapacityCp(state_l);
  lsat.pt=-Modelica.Constants.inf "Derivative of pressure wrt. temperature";
  lsat.cv=Medium_CoolProp.specificHeatCapacityCv(state_l);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Water_sat_P_ModelicaMedia;
