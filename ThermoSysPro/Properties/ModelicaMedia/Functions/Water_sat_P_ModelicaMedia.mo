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
      ThermoSysPro.Properties.ModelicaMedia.Media.ModelicaMedium             "CoolProp Medium" annotation(Evaluate=true, Dialog(tab="Fluid", group="CoolProp properties (enable if FluidType.CoolPropMedium)",enable=(ftype == FluidType.CoolPropMedium)));

equation

  state_l=Medium_CoolProp.setState_ph(p=P, h=sat.hl, phase=0);
  state_v=Medium_CoolProp.setState_ph(p=P, h=sat.hv, phase=0);

  vsat.P=P "Pressure";
  vsat.T=state_v.T "Temperature";
  vsat.rho=state_v.d "Density";
  vsat.h=state_v.h "Specific enthalpy";
  vsat.cp=state_v.cp;
  vsat.pt=-Modelica.Constants.inf "Derivative of pressure wrt. temperature";
  vsat.cv=state_v.cv;

  lsat.P=P "Pressure";
  lsat.T=state_l.T "Temperature";
  lsat.rho=state_l.d "Density";
  lsat.h=state_l.h "Specific enthalpy";
  lsat.cp=state_l.cp;
  lsat.pt=-Modelica.Constants.inf "Derivative of pressure wrt. temperature";
  lsat.cv=state_l.cv;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Water_sat_P_ModelicaMedia;
