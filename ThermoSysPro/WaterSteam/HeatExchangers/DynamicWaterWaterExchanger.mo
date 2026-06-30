within ThermoSysPro.WaterSteam.HeatExchangers;

model DynamicWaterWaterExchanger "Dynamic plate heat exchanger"
  parameter Units.SI.ThermalConductivity lambdam = 15.0 "Metal thermal conductivity";
  parameter Units.SI.CoefficientOfHeatTransfer p_hc = 6000 "Heat transfer coefficient for the hot side if not computed by the correlations";
  parameter Units.SI.CoefficientOfHeatTransfer p_hf = 3000 "Heat transfer coefficient for the cold side if not computed by the correlations";
  parameter Real p_Kc = 100 "Pressure loss coefficient for the hot side if not computed by the correlations";
  parameter Real p_Kf = 100 "Pressure loss coefficient for the cold side if not computed by the correlations";
  parameter Units.SI.Volume Vc = 1 "Hot side volume";
  parameter Units.SI.Volume Vf = 1 "Cold side volume";
  parameter Units.SI.Thickness emetal = 0.0006 "Wall thickness";
  parameter Units.SI.Area Sp = 2 "Plate area";
  parameter Real nbp = 499 "Number of plates";
  parameter Real c1 = 1.12647 "Correction coefficient";
  parameter Integer N = 10 "Number of segments";
  parameter Boolean steady_state = true "true: start from steady state";
  parameter Units.SI.Density p_rhoc = 0 "If > 0, fixed fluid density for the hot fluid";
  parameter Units.SI.Density p_rhof = 0 "If > 0, fixed fluid density for the cold fluid";
  parameter Integer modec = 0 "IF97 region for the hot fluid. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer modef = 0 "IF97 region for the cold fluid. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer heat_exchange_correlation = 1 "Correlation for the computation of the heat exchange coefficient - 0: no correlation. 1: SRI correlations";
  parameter Integer pressure_loss_correlation = 1 "Correlation for the computation of the pressure loss coefficient - 0: no correlation. 1: SRI correlations";
  Units.SI.Power dW[N] "Thermal power exchanged between the two sides";
  ThermoSysPro.Units.SI.PressureDifference DPc[N] "Pressure loss of the hot fluid";
  ThermoSysPro.Units.SI.PressureDifference DPf[N] "Pressure loss of the cold fluid";
  Units.SI.CoefficientOfHeatTransfer hc[N] "Heat transfer coefficient of the hot fluid";
  Units.SI.CoefficientOfHeatTransfer hf[N] "Heat transfer coefficient of the cold fluid";
  Units.SI.CoefficientOfHeatTransfer K[N] "Global heat transfer coefficient";
  Units.SI.Area dS "Heat exchange surface";
  Units.SI.Temperature Tec "Fluid temperature at the hot inlet";
  Units.SI.Temperature Tsc "Fluid temperature at the hot outlet";
  Units.SI.Temperature Tef "Fluid temperature at the cold inlet";
  Units.SI.Temperature Tsf "Fluid temperature at the cold outlet";
  Units.SI.AbsolutePressure Pcc[N + 1] "Hot fluid pressure at the boundary of section i";
  Units.SI.MassFlowRate Qcc[N + 1] "Hot fluid mass flow rate at the boundary of section i";
  Units.SI.SpecificEnthalpy Hcc[N + 1] "Hot fluid specific enthalpy at the boundary of section i";
  Units.SI.AbsolutePressure Pcf[N + 1] "Cold fluid pressure at the boundary of section i";
  Units.SI.MassFlowRate Qcf[N + 1] "Cold fluid mass flow rate at the boundary of section i";
  Units.SI.SpecificEnthalpy Hcf[N + 1] "Cold fluid specific enthalpy at the boundary of section i";
  Units.SI.MassFlowRate Qc[N](start = fill(500, N)) "Mass flow rate of the hot fluid";
  Units.SI.MassFlowRate Qf[N](start = fill(500, N)) "Mass flow rate of the cold fluid";
  Real qmc[N];
  Real qmf[N];
  Real quc[N];
  Real quf[N];
  Real M;
  Units.SI.Density rhoc[N](start = fill(998, N)) "Hot fluid density";
  Units.SI.Density rhof[N](start = fill(998, N)) "Cold fluid density";
  Units.SI.DynamicViscosity muc[N](start = fill(1.e-3, N)) "Hot fluid dynamic viscosity";
  Units.SI.DynamicViscosity muf[N](start = fill(1.e-3, N)) "Cold fluid dynamic viscosity";
  Units.SI.ThermalConductivity lambdac[N](start = fill(0.602698, N)) "Hot fluid thermal conductivity";
  Units.SI.ThermalConductivity lambdaf[N](start = fill(0.597928, N)) "Cold fluid thermal conductivity";
  Units.SI.Temperature Tmc[N](start = fill(290, N)) "Hot fluid average temperature";
  Units.SI.Temperature Tmf[N](start = fill(290, N)) "Cold fluid average temperature";
  Units.SI.AbsolutePressure Pmc[N](start = fill(1.e5, N)) "Hot fluid average pressure";
  Units.SI.AbsolutePressure Pmf[N](start = fill(1.e5, N)) "Cold fluid average pressure";
  Units.SI.SpecificEnthalpy Hmc[N](start = fill(100000, N)) "Hot fluid average specific enthalpy";
  Units.SI.SpecificEnthalpy Hmf[N](start = fill(100000, N)) "Cold fluid average specific enthalpy";
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proc[N] "Propriétés du fluide chaud" annotation(
    Placement(transformation(extent = {{-60, -100}, {-40, -80}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prof[N] "Propriétés du fluide froid" annotation(
    Placement(transformation(extent = {{-100, -100}, {-80, -80}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proce "Propriétés du fluide chaud en entrée" annotation(
    Placement(transformation(extent = {{-20, 80}, {0, 100}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph procs "Propriétés du fluide chaud en sortie" annotation(
    Placement(transformation(extent = {{20, 80}, {40, 100}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph profe "Propriétés du fluide froid en entrée" annotation(
    Placement(transformation(extent = {{-100, 80}, {-80, 100}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph profs "Propriétés du fluide froid en sortie" annotation(
    Placement(transformation(extent = {{-60, 80}, {-40, 100}}, rotation = 0)));
  Connectors.FluidInlet Ec annotation(
    Placement(transformation(extent = {{-110, -10}, {-90, 10}}, rotation = 0)));
  Connectors.FluidInlet Ef annotation(
    Placement(transformation(extent = {{-60, -70}, {-40, -50}}, rotation = 0)));
  Connectors.FluidOutlet Sf annotation(
    Placement(transformation(extent = {{40, -70}, {60, -50}}, rotation = 0)));
  Connectors.FluidOutlet Sc annotation(
    Placement(transformation(extent = {{90, -10}, {110, 10}}, rotation = 0)));
initial equation
  if steady_state then
    for i in 1:N loop
      der(Hmc[i]) = 0;
      der(Hmf[i]) = 0;
    end for;
  else
    for i in 1:N loop
      Hmc[i] = if (Ec.Q >= 0) then Ec.h else Sc.h;
      Hmf[i] = if (Ef.Q >= 0) then Ef.h else Sf.h;
    end for;
  end if;
equation
  Ec.P = Pcc[1];
  Sc.P = Pcc[N + 1];
  Ec.Q = Qcc[1];
  Sc.Q = Qcc[N + 1];
  Ec.h = Hcc[1];
  Sc.h = Hcc[N + 1];
  Ef.P = Pcf[N + 1];
  Sf.P = Pcf[1];
  Ef.Q = Qcf[N + 1];
  Sf.Q = Qcf[1];
  Ef.h = Hcf[N + 1];
  Sf.h = Hcf[1];
/* Flow reversal */
  0 = if (Ec.Q > 0) then Ec.h - Ec.h_vol else Sc.h - Sc.h_vol;
  0 = if (Ef.Q > 0) then Ef.h - Ef.h_vol else Sf.h - Sf.h_vol;
/* Exchange area for the plate exchanger */
  dS = (nbp - 2)*Sp/N;
  M = (nbp - 1)/2;
  for i in 1:N loop
/* Mass flow rates */
    Qcc[i] = Qcc[i + 1];
    Qcf[i] = Qcf[i + 1];
    Qc[i] = Qcc[i];
    Qf[i] = Qcf[i];
/* Pressure losses */
    Pcc[i + 1] = if (Qc[i] > 0) then Pcc[i] - DPc[i]/N else Pcc[i] + DPc[i]/N;
    Pcf[i + 1] = if (Qf[i] > 0) then Pcf[i] + DPf[i]/N else Pcf[i] - DPf[i]/N;
/* Heat transfer */
/* K = 1/(1/hc + 1/hf + emetal/lambdam) */
    K[i] = hc[i]*hf[i]/(hc[i] + hf[i] + hc[i]*hf[i]*emetal/lambdam);
    dW[i] = K[i]*dS*(Tmc[i] - Tmf[i]);
    Vc/N*rhoc[i]*der(Hmc[i]) = Qcc[i]*Hcc[i] - Qcc[i + 1]*Hcc[i + 1] - dW[i];
    Vf/N*rhof[i]*der(Hmf[i]) = -Qcf[i]*Hcf[i] + Qcf[i + 1]*Hcf[i + 1] + dW[i];
/* Heat trasnfer correlations */
    qmc[i] = noEvent(abs(Qc[i])/(max(ThermoSysPro.Properties.WaterSteam.InitLimits.ETAMIN, muc[i])*M));
    qmf[i] = noEvent(abs(Qf[i])/(max(ThermoSysPro.Properties.WaterSteam.InitLimits.ETAMIN, muf[i])*M));
    if (heat_exchange_correlation == 0) then
      hc[i] = p_hc;
      hf[i] = p_hf;
    elseif (heat_exchange_correlation == 1) then
      hc[i] = noEvent(if (qmc[i] < 1.e-3) then 0 else 11.245*abs(qmc[i])^0.8*abs(muc[i]*proc[i].cp/lambdac[i])^0.4*lambdac[i]);
      hf[i] = noEvent(if (qmf[i] < 1.e-3) then 0 else 11.245*abs(qmf[i])^0.8*abs(muf[i]*prof[i].cp/lambdaf[i])^0.4*lambdaf[i]);
    else
      hc[i] = 0;
      hf[i] = 0;
      assert(false, "DynamicWaterWaterExchanger: incorrect heat exchange correlation number");
    end if;
/* Pressure losses correlations */
    quc[i] = noEvent(abs(Qc[i])/M);
    quf[i] = noEvent(abs(Qf[i])/M);
    if (pressure_loss_correlation == 0) then
      DPc[i] = p_Kc*Qc[i]^2/rhoc[i];
      DPf[i] = p_Kf*Qf[i]^2/rhof[i];
    elseif (pressure_loss_correlation == 1) then
      DPc[i] = noEvent(if (qmc[i] < 1.e-3) then 0 else c1*14423.2/rhoc[i]*abs(qmc[i])^(-0.097)*quc[i]^2*(1472.47 + 1.54*(M - 1)/2 + 104.97*abs(qmc[i])^(-0.25)));
      DPf[i] = noEvent(if (qmf[i] < 1.e-3) then 0 else 14423.2/rhof[i]*abs(qmf[i])^(-0.097)*quf[i]^2*(1472.47 + 1.54*(M - 1)/2 + 104.97*abs(qmf[i])^(-0.25)));
    else
      DPc[i] = 0;
      DPf[i] = 0;
      assert(false, "DynamicWaterWaterExchanger: incorrect pressure loss correlation number");
    end if;
/* Fluid thermodynamic properties */
    Pmc[i] = (Pcc[i] + Pcc[i + 1])/2;
    Pmf[i] = (Pcf[i] + Pcf[i + 1])/2;
    Hmc[i] = (Hcc[i] + Hcc[i + 1])/2;
    Hmf[i] = (Hcf[i] + Hcf[i + 1])/2;
    proc[i] = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Pmc[i], Hmc[i], modec);
    prof[i] = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Pmf[i], Hmf[i], modef);
    Tmc[i] = proc[i].T;
    Tmf[i] = prof[i].T;
    if (p_rhoc > 0) then
      rhoc[i] = p_rhoc;
    else
      rhoc[i] = proc[i].d;
    end if;
    if (p_rhof > 0) then
      rhof[i] = p_rhof;
    else
      rhof[i] = prof[i].d;
    end if;
    muc[i] = ThermoSysPro.Properties.WaterSteam.IF97.DynamicViscosity_rhoT(rhoc[i], Tmc[i]);
    muf[i] = ThermoSysPro.Properties.WaterSteam.IF97.DynamicViscosity_rhoT(rhof[i], Tmf[i]);
    lambdac[i] = ThermoSysPro.Properties.WaterSteam.IF97.ThermalConductivity_rhoT(rhoc[i], Tmc[i], Pmc[i]);
    lambdaf[i] = ThermoSysPro.Properties.WaterSteam.IF97.ThermalConductivity_rhoT(rhof[i], Tmf[i], Pmf[i]);
  end for;
/* Fluid temperatures at the inlet and the outlet of the exchanger */
  proce = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Ec.P, Ec.h, modec);
  procs = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Sc.P, Sc.h, modec);
  profe = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Ef.P, Ef.h, modef);
  profs = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Sf.P, Sf.h, modef);
  Tec = proce.T;
  Tsc = procs.T;
  Tef = profe.T;
  Tsf = profs.T;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Rectangle(extent = {{-100, 60}, {100, -60}}, lineColor = {0, 0, 0}, fillColor = {127, 255, 0}, fillPattern = FillPattern.Solid), Line(points = {{-80, 60}, {-80, -60}}), Line(points = {{80, 60}, {80, -60}}), Line(points = {{-80, 0}, {-60, 0}, {-40, 20}, {40, -20}, {60, 0}, {80, 0}}, color = {0, 0, 255}), Line(points = {{-40, 60}, {-40, -60}}, color = {0, 0, 255}, pattern = LinePattern.Dot), Line(points = {{0, 60}, {0, -60}}, color = {0, 0, 255}, pattern = LinePattern.Dot), Line(points = {{40, 60}, {40, -60}}, color = {0, 0, 255}, pattern = LinePattern.Dot)}),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Rectangle(extent = {{-100, 60}, {100, -60}}, lineColor = {0, 0, 255}, fillColor = {127, 255, 0}, fillPattern = FillPattern.Solid), Line(points = {{-80, 60}, {-80, -60}}), Line(points = {{80, 60}, {80, -60}}), Line(points = {{-80, 0}, {-60, 0}, {-40, 20}, {40, -20}, {60, 0}, {80, 0}}, color = {0, 0, 255}), Line(points = {{-40, 60}, {-40, -60}}, color = {0, 0, 255}, pattern = LinePattern.Dot), Line(points = {{0, 60}, {0, -60}}, color = {0, 0, 255}, pattern = LinePattern.Dot), Line(points = {{40, 60}, {40, -60}}, color = {0, 0, 255}, pattern = LinePattern.Dot)}),
    Window(x = 0.04, y = 0.05, width = 0.93, height = 0.91),
    Documentation(info = "
## Copyright © EDF 2002 - 2026  
## ThermoSysPro Version 4.2  
This component model is documented in Sect. 9.6.1 of the ThermoSysPro book.   
# Dynamic water water exchanger   
   
The plate heat exchanger is composed of thousand sheets separated from each other by a small space where fluids flow. The plates exhibit a wavy surface to create a turbulent flow that generates better heat transfers. This type of exchanger is widely used in the food industry as it can easily be taken apart for cleanup.  

This model represents a single-phase counter-flow thermal exchange between the hot fluid and the cold fluid. The two fluids are separated by a wall through which heat transfer takes place by conduction. Convection transfers the heat between each fluid and the wall.  

Following assumptions are made:  
- the flow in each mesh cell is single-phase.  
- the energy accumulation in the wall is neglected.  
- the phenomenon of longitudinal heat conduction in the wall and in the fluid is neglected.  
- the pressure and specific enthalpy are assumed constant in each mesh cell.  

For a steady-state plate heat exchanger, see [static water water exchanger](modelica://ThermoSysPro.WaterSteam.HeatExchangers.StaticWaterWaterExchanger).  

## Modelica component model  

The equations mentioned below are implemented in the component *DynamicWaterWaterExchanger*, located in the *WaterSteam.HeatExchangers* sub-library.   
   
![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.HeatExchangers.DynamicWaterWaterExchanger.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.HeatExchangers.DynamicWaterWaterExchanger.svg)  

## Nomenclature  

| Symbol| Description| Unit| Definition| Modelica name |  
| :-------------------------------- | :------------------------------------------------------------------------------------------ | :------------------------------------------- | :----------------------------------------------------------------------------------------------------------------------- | :----------- |  
| \\\\(c\\_{p, c, i}\\\\)| Cold fluid specific heat in thermal cell \\\\(i\\\\)| \\\\(\\mathrm{J} / \\mathrm{kg} / \\mathrm{K}\\\\)|| prof[i].cp |  
| \\\\(c\\_{p, \\mathrm{h}, i}\\\\)| Hot fluid specific heat in thermal cell \\\\(i\\\\)| \\\\(\\mathrm{J} / \\mathrm{kg} / \\mathrm{K}\\\\)|| proc[i].cp |  
| \\\\(D\\_{\\mathrm{h}}\\\\)| Hydraulic diameter| \\\\(\\mathrm{m}\\\\)|| - |  
| \\\\(e\\_{\\mathrm{m}}\\\\)| Wall thickness| \\\\(\\mathrm{m}\\\\)|| emetal |  
| \\\\(h\\_{\\mathrm{c}, i}\\\\)| Cold fluid specific enthalpy in thermal cell \\\\(i\\\\)| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| Hmf[i] |  
| \\\\(h\\_{\\mathrm{c}, i: i+1}\\\\)| Cold fluid specific enthalpy in hydraulic cell \\\\(i: i+1\\\\)| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| Hcf[i] |  
| \\\\(h\\_{\\mathrm{h}, i}\\\\)| Hot fluid specific enthalpy in thermal cell \\\\(i\\\\)| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| Hmc[i] |  
| \\\\(h\\_{\\mathrm{h}, i: i+1}\\\\)| Hot fluid specific enthalpy in hydraulic cell \\\\(i: i+1\\\\)| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| Hcc[i] |  
| \\\\(K\\_{\\mathrm{c}, i}\\\\)| Convective heat exchange coefficient for the cold fluid in thermal cell \\\\(i\\\\)| \\\\(\\mathrm{W} / \\mathrm{m}^{2} / \\mathrm{K}\\\\) || hf[i] |  
| \\\\(K\\_{\\mathrm{h}, i}\\\\)| Convective heat exchange coefficient for the hot fluid in thermal cell \\\\(i\\\\)| \\\\(\\mathrm{W} / \\mathrm{m}^{2} / \\mathrm{K}\\\\) || hc[i] |  
| \\\\(m\\_{\\mathrm{c}, i: i+1}\\\\)| Cold fluid mass flow rate in hydraulic cell \\\\(i:\\\\) \\\\(i+1\\\\)| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Qcf[i] |  
| \\\\(m\\_{\\mathrm{h}, i: i+1}\\\\)| Hot fluid mass flow rate in hydraulic cell \\\\(i:\\\\) \\\\(i+1\\\\)| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Qcc[i] |  
| \\\\(N\\\\)| Number of hydraulic cells| \\\\(-\\\\)|| N + 1 |  
| \\\\(N\\_{\\mathrm{c}}\\\\)| Number of channels of each fluid| \\\\(-\\\\)| \\\\(\\left\\(N\\_{\\mathrm{p}}-1\\right\\) / 2\\\\)| - |  
| \\\\(N\\_{\\mathrm{p}}\\\\)| Number of plates| \\\\(-\\\\)|| nbp |  
| \\\\(P\\_{\\mathrm{c}, i}\\\\)| Cold fluid pressure at the outlet of thermal cell \\\\(i\\\\)| \\\\(\\mathrm{Pa}\\\\)|| Pcf[i + 1] |  
| \\\\(P\\_{\\mathrm{h}, i}\\\\)| Hot fluid pressure at the outlet of thermal cell \\\\(i\\\\)| \\\\(\\mathrm{Pa}\\\\)|| Pcc[i + 1] |  
| \\\\(P r\\_{\\mathrm{c}, i}\\\\)| Prandtl number of the cold fluid in thermal cell \\\\(i\\\\)| \\\\(-\\\\)| \\\\(\\frac{\\mu\\_{\\mathrm{c}, i} \\cdot c\\_{p, \\mathrm{c}, i}}{\\lambda\\_{\\mathrm{c}, i}}\\\\)| - |  
| \\\\(P r\\_{h, i}\\\\)| Prandtl number of the hot fluid in thermal cell \\\\(i\\\\)| \\\\(-\\\\)| \\\\(\\frac{\\mu\\_{\\mathrm{h}, i} \\cdot c\\_{p, \\mathrm{h}, i}}{\\lambda\\_{\\mathrm{h}, i}}\\\\)| - |  
| \\\\(R e\\_{c, i:i+1}\\\\)| Reynolds number of the cold fluid in hydraulic cell \\\\(i: i+1\\\\)| \\\\(-\\\\)| \\\\(\\frac{4 \\cdot m\\_{\\mathrm{c}, i: i+1}}{\\pi \\cdot D\\_{\\mathrm{h}} \\cdot \\mu\\_{\\mathrm{c}, i} \\cdot N\\_{\\mathrm{c}}}\\\\)| - |  
| \\\\(R e\\_{\\mathrm{h}, i: i+1}\\\\)| Reynolds number of the hot fluid in hydraulic cell \\\\(i: i+1\\\\)| \\\\(-\\\\)| \\\\(\\frac{4 \\cdot \\dot{m}\\_{\\mathrm{h}, i: i+1}}{\\pi \\cdot D\\_{\\mathrm{h}} \\cdot \\mu\\_{\\mathrm{h}, i} \\cdot N\\_{\\mathrm{c}}}\\\\) | - |  
| \\\\(S\\_{\\mathrm{p}}\\\\)| Plate area| \\\\(\\mathrm{m}^{2}\\\\)|| Sp |  
| \\\\(T\\_{\\mathrm{c}, i}\\\\)| Temperature of the cold fluid in thermal cell \\\\(i\\\\)| \\\\(\\mathrm{K}\\\\)|| Tmf[i] |  
| \\\\(T\\_{\\mathrm{h}, i}\\\\)| Temperature of the hot fluid in thermal cell \\\\(i\\\\)| \\\\(\\mathrm{K}\\\\)|| Tmc[i] |  
| \\\\(T\\_{\\mathrm{w}, \\mathrm{c}, i}\\\\) | Wall temperature of for cold fluid in thermal cell \\\\(i\\\\)| \\\\(\\mathrm{K}\\\\)|| Tmf[i] |  
| \\\\(T\\_{\\mathrm{w}, \\mathrm{h}, i}\\\\) | Wall temperature for the hot fluid in thermal cell \\\\(i\\\\)| \\\\(\\mathrm{K}\\\\)|| Tmc[i] |  
| \\\\(U\\_{i}\\\\)| Global heat transfer coefficient for thermal cell \\\\(i\\\\)| \\\\(\\mathrm{W} / \\mathrm{m}^{2} / \\mathrm{K}\\\\) || K[i] |  
| \\\\(V\\_{\\mathrm{c}}\\\\)| Cold fluid volume| \\\\(\\mathrm{m}^{3}\\\\)|| Vf |  
| \\\\(V\\_{\\mathrm{h}}\\\\)| Hot fluid volume| \\\\(\\mathrm{m}^{3}\\\\)|| Vc |  
| \\\\(\\Delta A\\_{i}\\\\)| Heat exchange surface for thermal cell \\\\(i\\\\)| \\\\(\\mathrm{m}^{2}\\\\)| \\\\(\\frac{s\\_{\\mathrm{p}} \\cdot\\left\\(N\\_{\\mathrm{p}}-2\\right\\)}{N-1}\\\\)| dS |  
| \\\\(\\Delta W\\_{i}\\\\)| Thermal power released by the hot fluid to the cold fluid for thermal cell \\\\(i\\\\)| \\\\(\\mathrm{W}\\\\)|| dW[i] |  
| \\\\(\\lambda\\_{\\mathrm{c}, i}\\\\)| Cold fluid thermal conductivity in thermal cell \\\\(i\\\\)| \\\\(\\mathrm{W} / \\mathrm{m} / \\mathrm{K}\\\\)|| lambdaf[i] |  
| \\\\(\\lambda\\_{\\mathrm{h}, i}\\\\)| Hot fluid thermal conductivity in thermal cell \\\\(i\\\\)| \\\\(\\mathrm{W} / \\mathrm{m} / \\mathrm{K}\\\\)|| lambdac[i] |  
| \\\\(\\lambda\\_{\\mathrm{m}}\\\\)| Metal thermal conductivity| \\\\(\\mathrm{W} / \\mathrm{m} / \\mathrm{K}\\\\)|| lambdam |  
| \\\\(\\Lambda\\_{\\mathrm{c}}\\\\)| Friction pressure loss coefficient of the entire length of the exchanger for the cold fluid | \\\\(\\mathrm{m}^{-4}\\\\)|| p_Kf |  
| \\\\(\\Lambda\\_{\\mathrm{h}}\\\\)| Friction pressure loss coefficient of the entire length of the exchanger for the hot fluid| \\\\(\\mathrm{m}^{-4}\\\\)|| p_Kc |  
| \\\\(\\mu\\_{\\mathrm{c}, i}\\\\)| Cold fluid dynamic viscosity in thermal cell \\\\(i\\\\)| \\\\(\\mathrm{Pa} \\mathrm{s}\\\\)|| muf[i] |  
| \\\\(\\mu\\_{\\mathrm{c}, i: i+1}\\\\)| Cold fluid dynamic viscosity in hydraulic cell \\\\(i: i+1\\\\)| \\\\(\\mathrm{Pa} \\mathrm{s}\\\\)|| muf[i] |  
| \\\\(\\mu\\_{\\mathrm{h}, i}\\\\)| Hot fluid dynamic viscosity in thermal cell \\\\(i\\\\)| \\\\(\\mathrm{Pa} \\mathrm{s}\\\\)|| muc[i] |  
| \\\\(\\mu\\_{\\mathrm{h}, i: i+1}\\\\)| Hot fluid dynamic viscosity in hydraulic cell \\\\(i: i+1\\\\)| \\\\(\\mathrm{Pa} \\mathrm{s}\\\\)|| muc[i] |  
| \\\\(\\rho\\_{\\mathrm{c}, i}\\\\)| Cold fluid density in thermal cell \\\\(i\\\\)| \\\\(\\mathrm{kg} / \\mathrm{m}^{3}\\\\)|| rhof[i] |  
| \\\\(\\rho\\_{\\mathrm{h}, i}\\\\)| Hot fluid density in thermal cell \\\\(i\\\\)| \\\\(\\mathrm{kg} / \\mathrm{m}^{3}\\\\)|| rhoc[i] |  


## Governing equations  

The following set of equations must be completed by the state equations for the following water and steam properties \\\\(c\\_{p, c}, c\\_{p, h}, \\rho\\_{c}, \\rho\\_{h}, \\mu\\_{c}, \\mu\\_{h}, \\lambda\\_{c}\\\\) and \\\\(\\lambda\\_{h}\\\\).  

### Steady-state mass balance equation (hot fluid)  


- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\_{\\mathrm{h}, i:i+1}\\\\)  

- Mathematical formulation:   
   
 $$\\dot{m}\\_{\\mathrm{h}, i-1:i}-\\dot{m}\\_{\\mathrm{h}, i:i+1}=0$$  

- Comments:   
   

### Steady-state mass balance equation (cold fluid)  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\_{\\mathrm{c}, i:i+1}\\\\)  

- Mathematical formulation:   
   
 $$\\dot{m}\\_{\\mathrm{c}, i-1:i}-\\dot{m}\\_{\\mathrm{c}, i:i+1}=0$$   

- Comments:   
   



### Dynamic energy balance equation (hot fluid)  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\_{\\mathrm{h}, i:i+1}\\\\)  

- Mathematical formulation:   
   
 $$\\frac{V\\_{\\mathrm{h}}}{N-1} \\cdot \\rho\\_{\\mathrm{h}, i} \\cdot \\frac{\\mathrm{d} h\\_{\\mathrm{h}, i}}{\\mathrm{d} t}=\\dot{m}\\_{\\mathrm{h}, i-1:i} \\cdot h\\_{\\mathrm{h}, i-1:i}-\\dot{m}\\_{\\mathrm{h}, i:i+1} \\cdot h\\_{\\mathrm{h}, i:i+1}-\\Delta W\\_{i}$$  

- Comments:   
   
 The fluid is assumed to be incompressible.  


### Dynamic energy balance equation (cold fluid)  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\_{c, i:i+1}\\\\)  

- Mathematical formulation:   
   
 $$\\frac{V\\_{\\mathrm{c}}}{N-1} \\cdot \\rho\\_{\\mathrm{c}, i} \\cdot \\frac{\\mathrm{d} h\\_{\\mathrm{c}, i}}{\\mathrm{d} t}=\\dot{m}\\_{\\mathrm{c}, i-1:i} \\cdot h\\_{\\mathrm{c}, i-1:i}-\\dot{m}\\_{\\mathrm{c}, i:i+1} \\cdot h\\_{\\mathrm{c}, i:i+1}+\\Delta W\\_{i}$$  

- Comments:   
   
 The fluid is assumed to be incompressible.  







    
    

### Heat exchanged between the hot and cold fluids  

- Validity domain:   
   
 \\\\(\\forall T\\_{\\mathrm{h}, i}\\\\) and \\\\(\\forall T\\_{\\mathrm{c}, i}\\\\)  

- Mathematical formulation:   
   
 $$\\Delta W\\_{i}=U\\_{i} \\cdot \\Delta A\\_{i} \\cdot\\left\\(T\\_{\\mathrm{h}, i}-T\\_{\\mathrm{c}, i}\\right\\)$$  

- Comments:   
   
 The global heat transfer coefficient \\\\(U\\_{i}\\\\) between the two fluids is given by \\\\(\\frac{1}{U\\_{i}}=\\frac{1}{K\\_{\\mathrm{h}, i}}+\\frac{1}{\\lambda\\_{\\mathrm{m}}}+\\frac{1}{K\\_{\\mathrm{c}, i}}\\\\).   
    

### Momentum balance equation (hot fluid)  

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\_{\\mathrm{h}, i:i+1}\\\\)  

- Mathematical formulation:   
   
 $$P\\_{\\mathrm{h}, i+1} = P\\_{\\mathrm{h}, i}-\\frac{\\Lambda\\_{\\mathrm{h}}}{N} \\cdot \\frac{\\dot{m}\\_{\\mathrm{h}, i:i+1} \\cdot \\lvert \\dot{m}\\_{\\mathrm{h}, i:i+1} \\rvert}{N\\_{\\mathrm{c}}^{2} \\cdot \\rho\\_{\\mathrm{h}, i}}$$  

- Comments:   
   
 Only pressure losses due to friction are taken into account. The friction coefficient \\\\(\\Lambda\\_{\\mathrm{h}}\\\\) can be directly provided by the user or computed using a correlation.  


### Momentum balance equation (cold fluid)  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\_{\\mathrm{c}, i:i+1}\\\\)  

- Mathematical formulation:   
   
 $$P\\_{\\mathrm{c}, i+1}=P\\_{\\mathrm{c}, i}-\\frac{\\Lambda\\_{\\mathrm{c}}}{N} \\cdot \\frac{\\dot{m}\\_{\\mathrm{c}, i:i+1} \\cdot \\lvert \\dot{m}\\_{\\mathrm{c}, i:i+1} \\rvert}{N\\_{\\mathrm{c}}^{2} \\cdot \\rho\\_{\\mathrm{c}, i}}$$  

- Comments:   
   
 Only pressure losses due to friction are taken into account. The friction coefficient \\\\(\\Lambda\\_{\\mathrm{c}}\\\\) can be directly provided by the user or computed using a correlation.  


## References   
   
El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 9.6.1. Springer Nature Switzerland AG.  
    ", revisions = "
Author  

Daniel Bouskela   

    "));
end DynamicWaterWaterExchanger;