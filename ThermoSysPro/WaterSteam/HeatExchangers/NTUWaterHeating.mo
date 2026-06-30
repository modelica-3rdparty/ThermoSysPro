within ThermoSysPro.WaterSteam.HeatExchangers;

model NTUWaterHeating "NTU water heater"
  parameter Real lambdaE = 0 "Pressure loss coefficient on the water side";
  parameter Units.SI.Area SCondDes = 3000 "Exchange surface for the condensation and deheating";
  parameter Units.SI.CoefficientOfHeatTransfer KCond = 1 "Heat transfer coefficient for the condensation";
  parameter Units.SI.Area SPurge = 0 "Drain surface - if > 0: with drain cooling";
  parameter Units.SI.CoefficientOfHeatTransfer KPurge = 1 "Heat transfer coefficient for the drain cooling";
  parameter Integer mode_eeF = 0 "IF97 region at the inlet of the water side. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_seF = 0 "IF97 region at the outlet of the water side. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_evC = 0 "IF97 region at the inlet of the vapor side. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_mF = 0 "IF97 region in the drain. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_epC = 0 "IF97 region at the inlet of the drain. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_spC = 0 "IF97 region at the outlet of the drain. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_flash = 0 "IF97 region in the flash zone of the drain. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  Units.SI.AbsolutePressure P(start = 10e5) "Fluid pressure";
  Units.SI.SpecificEnthalpy h(start = 10e5) "Fluid specific enthalpy";
  Units.SI.SpecificEnthalpy HsateC(start = 300e3, min = 0) "Saturation specific enthalpy of the water at the pressure of the vapor inlet";
  Units.SI.SpecificEnthalpy HsatvC(start = 2500e3, min = 0) "Saturation specific enthalpy of the vapor at the pressure of the vapor inlet";
  Units.SI.Area SDes(start = 0) "Heat exchange surface for deheating";
  Units.SI.SpecificEnthalpy HeiF(start = 200e3) "Fluid specific enthalpy after drain cooling";
  Units.SI.SpecificEnthalpy HDesF(start = 200e3) "Fluid specific enthalpy after deheating";
  Units.SI.Temperature TeiF(start = 400, min = 0) "Fluid temperature after drain cooling";
  Units.SI.Temperature TsatC(start = 400, min = 0) "Saturation temperature";
  Units.SI.Power W(start = 1) "Total heat power transfered to the cooling water";
  Units.SI.Power Wdes(start = 1) "Energy transfer during deheating";
  Units.SI.Power Wcond(start = 1) "Energy transfer during condensation";
  Units.SI.Power Wflash(start = 1) "Energy transfer during partial vaporisation in the drain";
  Units.SI.Power Wpurge(start = 1) "Energy transfer during drain cooling";
  Units.SI.SpecificEnthalpy Hep(start = 3e5) "Mixing specific enthalpy of the drain and the condensate";
  Units.SI.Density rho(start = 1e3, min = 0) "Average water density";
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proeeF "Water inlet fluid properties (4F)" annotation(
    Placement(transformation(extent = {{-100, -100}, {-80, -80}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proseF "Water outlet fluid properties (1F)" annotation(
    Placement(transformation(extent = {{-70, -100}, {-50, -80}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prospC "Drain outlet fluid properties (4C)" annotation(
    Placement(transformation(extent = {{-100, 80}, {-80, 100}}, rotation = 0)));
  Connectors.FluidInlet Ee(h_vol(start = 200e3)) "Water inlet" annotation(
    Placement(transformation(extent = {{-92, -10}, {-112, 10}}, rotation = 0)));
  Connectors.FluidOutlet Se "Water outlet" annotation(
    Placement(transformation(extent = {{110, -10}, {90, 10}}, rotation = 0)));
  Connectors.FluidInlet Ep(h_vol(start = 200e3)) "Drain inlet" annotation(
    Placement(transformation(extent = {{-50, 24}, {-70, 44}}, rotation = 0)));
  Connectors.FluidOutlet Sp "Drain outlet" annotation(
    Placement(transformation(extent = {{-50, -43}, {-70, -23}}, rotation = 0)));
  Connectors.FluidInlet Ev(h_vol(start = 200e3)) "Vapor inlet" annotation(
    Placement(transformation(extent = {{70, 22}, {50, 42}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proevC "Vapor inlet fluid properties (1C)" annotation(
    Placement(transformation(extent = {{-70, 80}, {-50, 100}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat lsatC "Saturation conditions for the liquid phase" annotation(
    Placement(transformation(extent = {{10, 40}, {30, 60}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat vsatC "Saturation conditions for the vapor phase" annotation(
    Placement(transformation(extent = {{-30, 40}, {-10, 60}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph promeF "Average water fluid properties (between 4F and 3F)" annotation(
    Placement(transformation(extent = {{-40, -100}, {-20, -80}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prodesmC "Deheating average fluid properties (between 1C and 2C)" annotation(
    Placement(transformation(extent = {{50, 80}, {70, 100}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph promcF "Average deheating fluid properties (between 3F and 2F)" annotation(
    Placement(transformation(extent = {{50, -100}, {70, -80}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prodesF "Deheating inlet fluid properties (2F)" annotation(
    Placement(transformation(extent = {{-10, -100}, {10, -80}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prodesmF "Average deheating fluid properties (between 2F and 1F)" annotation(
    Placement(transformation(extent = {{20, -100}, {40, -80}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prosp "Drain outlet fluid properties before cooling (near 3C)" annotation(
    Placement(transformation(extent = {{-40, 80}, {-20, 100}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prompC "Average fluid properties in the drain (between 3C and 4C)" annotation(
    Placement(transformation(extent = {{20, 80}, {40, 100}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prompF "Average water fluid properties (between 4F and 3F)" annotation(
    Placement(transformation(extent = {{-100, -60}, {-80, -40}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proecF "Water fluid properties (3F)" annotation(
    Placement(transformation(extent = {{80, -100}, {100, -80}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph flashepC "Flash fluid properties (near 4C)" annotation(
    Placement(transformation(extent = {{80, 80}, {100, 100}}, rotation = 0)));
protected
  parameter Real eps = 1.e-3 "Small number for pressure loss equation";
equation
/* Unconnected connectors */
  if cardinality(Ep) == 0 then
    Ep.Q = 1e-6;
    Ep.h = 100e3;
    Ep.P = 1e5;
    Ep.b = true;
  end if;
// Cooling pipe
//-------------
/* Flow reversal for the cooling water pipe */
  0 = if noEvent(Ee.Q > 0) then Ee.h - Ee.h_vol else Se.h - Se.h_vol;
/* Mass balance equation for the water pipe */
  Se.Q = Ee.Q;
/* Pressure loss equation in the water pipe */
  Ee.P - Se.P = lambdaE*ThermoSysPro.Functions.ThermoSquare(Ee.Q, eps)/rho;
/* Heating power released to the cooling pipe */
  W = Se.Q*(Se.h - Ee.h);
// Water/steam cavity
//-------------------
/* Fluid pressure */
  P = Ev.P;
  P = Sp.P;
/* Fluid specific enthalpy (singular if all flows = 0) */
  Sp.h_vol = h;
  Ev.h_vol = h;
  Ep.h_vol = h;
/* Mass balance equation */
  Sp.Q = Ev.Q + Ep.Q;
/* Energy balance equations */
// Deheating zone
//---------------
/* Heat power, fluid specific enthalpy on the cold side and deheating surface */
/* If deheating is present */
  if noEvent(HsatvC < Ev.h) then
    Wdes = Ev.Q*(Ev.h - HsatvC);
    Wdes = Ee.Q*(Se.h - HDesF);
    Wdes = noEvent(min(Ev.Q*prodesmC.cp, Ee.Q*prodesmF.cp)*ThermoSysPro.Correlations.Thermal.WBHeatExchangerEfficiency(Ev.Q, Ee.Q, prodesmC.cp, prodesmF.cp, KCond/2, SDes, 1)*(proevC.T - prodesF.T));
/* If deheating is absent */
  else
    Wdes = 1e-9;
    HDesF = Se.h;
    SDes = 1e-9;
  end if;
// Condensation zone
//------------------
/* Heat power, fluid specific enthalpy at the outlet of the condensation zone and vapor mass flow rate at the inlet */
  if noEvent(Ev.h < HsatvC) then
    Wcond = Ev.Q*(Ev.h - HsateC) + Wflash;
  else
    Wcond = Ev.Q*(HsatvC - HsateC) + Wflash;
  end if;
  Wcond = Ee.Q*(HDesF - HeiF);
  Wcond = Ee.Q*promcF.cp*ThermoSysPro.Correlations.Thermal.WBHeatExchangerEfficiency(Ev.Q, Ee.Q, 1.e20, promcF.cp, KCond, (SCondDes - SDes), 0.5)*(TsatC - TeiF);
// Flash zone
//-----------
/* Heat power in case of partial vaporization in the drain */
  if (flashepC.x > 0) then
    Wflash = Ep.Q*(Ep.h - HsateC);
  else
    Wflash = 0;
  end if;
/* Condition for partial vaporisation in the drain (flash) */
  if (flashepC.x > 0) then
    Hep = HsateC;
  else
    Sp.Q*Hep = HsateC*Ev.Q + Ep.h*Ep.Q;
  end if;
// Drain cooling zone
//-------------------
/* Power, fluid specific enthalpy at the cold outlet and temperature of the drain outlet */
  if noEvent(SPurge > 0) then
    Wpurge = Sp.Q*(Hep - Sp.h);
    Wpurge = Ee.Q*(HeiF - Ee.h);
    Wpurge = noEvent(min(Sp.Q*prompC.cp, Ee.Q*prompF.cp)*ThermoSysPro.Correlations.Thermal.WBHeatExchangerEfficiency(Sp.Q, Ee.Q, prompC.cp, prompF.cp, KPurge, SPurge, 0)*(prosp.T - proeeF.T));
    TeiF = proecF.T;
  else
    HeiF = Ee.h;
    Wpurge = 0;
    Hep = Sp.h;
    TeiF = proeeF.T;
  end if;
/* Fluid thermodynamic properties */
  proeeF = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Ee.P, Ee.h, mode_eeF);
  proseF = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Se.P, Se.h, mode_seF);
  promeF = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph((Ee.P + Se.P)/2, (Ee.h + Se.h)/2, mode_eeF);
  proevC = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Ev.P, Ev.h, mode_evC);
  prospC = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Sp.P, Sp.h, mode_spC);
  prosp = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Ev.P, Hep, mode_spC);
  prodesF = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Se.P, HDesF, mode_seF);
  prompC = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Ev.P, (Hep + Sp.h)/2, mode_spC);
  prodesmC = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Ev.P, (vsatC.h + Ev.h)/2, mode_evC);
  prompF = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Ee.P, (Ee.h + HeiF)/2, mode_eeF);
  promcF = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph((Ee.P + Se.P)/2, (HeiF + HDesF)/2, mode_mF);
  prodesmF = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Se.P, (HDesF + Se.h)/2, mode_seF);
  proecF = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Ee.P, HeiF, mode_eeF);
  flashepC = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Ev.P, Ep.h, mode_flash);
/* Fluid density */
  rho = promeF.d;
/* Saturation point at the vapor inlet pressure */
  (lsatC, vsatC) = ThermoSysPro.Properties.WaterSteam.IF97.Water_sat_P(Ev.P);
  TsatC = lsatC.T;
  HsateC = lsatC.h;
  HsatvC = vsatC.h;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}, initialScale = 0.01), graphics = {Ellipse(extent = {{-100, -30}, {-36, 32}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {85, 255, 85}, fillPattern = FillPattern.Solid), Ellipse(extent = {{38, -30}, {102, 32}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {85, 255, 85}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-68, 32}, {72, -30}}, lineColor = {85, 255, 85}, lineThickness = 0.5, fillColor = {85, 255, 85}, fillPattern = FillPattern.Solid), Line(points = {{-70, 32}, {74, 32}, {74, 32}}, color = {0, 0, 0}, thickness = 0.5), Line(points = {{-70, -30}, {74, -30}, {74, -30}}, color = {0, 0, 0}, thickness = 0.5), Line(points = {{74, 32}, {74, -30}}, color = {0, 0, 0}, thickness = 0.5), Line(points = {{74, 0}, {102, 0}}, color = {0, 0, 0}, thickness = 0.5), Rectangle(extent = {{-58, -14}, {74, -16}}, lineColor = {0, 255, 255}, lineThickness = 1, fillColor = {0, 255, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-58, 16}, {74, 14}}, lineColor = {0, 255, 255}, lineThickness = 1, fillColor = {0, 255, 255}, fillPattern = FillPattern.Solid), Ellipse(extent = {{-78, -16}, {-44, 16}}, lineColor = {0, 255, 255}, lineThickness = 1, fillColor = {0, 255, 255}, fillPattern = FillPattern.Solid), Ellipse(extent = {{-76, -14}, {-48, 14}}, lineColor = {0, 255, 0}, lineThickness = 1, fillColor = {85, 255, 85}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-62, 14}, {72, -14}}, lineColor = {85, 255, 85}, fillColor = {85, 255, 85}, fillPattern = FillPattern.Solid), Line(points = {{-94, -12}, {74, -12}}, color = {0, 0, 255}, pattern = LinePattern.Dash), Line(points = {{-94, -18}, {74, -18}}, color = {0, 0, 255}, pattern = LinePattern.Dash), Line(points = {{-86, -24}, {74, -24}}, color = {0, 0, 255}, pattern = LinePattern.Dash)}),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}, initialScale = 0.01), graphics = {Line(points = {{-40, -40}, {20, -24}}, color = {0, 0, 255}, thickness = 0.5, arrow = {Arrow.None, Arrow.Filled}), Line(points = {{-40, -20}, {-20, 0}}, color = {255, 0, 0}, thickness = 0.5), Line(points = {{-20, 0}, {20, 0}}, color = {255, 0, 0}, thickness = 0.5), Line(points = {{60, 0}, {80, 20}}, color = {255, 0, 0}, thickness = 0.5), Text(extent = {{76, 28}, {84, 20}}, lineColor = {255, 0, 0}, lineThickness = 0.5, textString = "1C"), Text(extent = {{56, 10}, {64, 2}}, lineColor = {255, 0, 0}, lineThickness = 0.5, textString = "2C"), Text(extent = {{-24, 8}, {-16, 0}}, lineColor = {255, 0, 0}, lineThickness = 0.5, textString = "3C"), Text(extent = {{-44, -10}, {-36, -18}}, lineColor = {255, 0, 0}, lineThickness = 0.5, textString = "4C"), Text(extent = {{76, -10}, {82, -16}}, lineColor = {0, 0, 255}, lineThickness = 0.5, textString = "1F"), Text(extent = {{58, -18}, {64, -24}}, lineColor = {0, 0, 255}, lineThickness = 0.5, textString = "2F"), Text(extent = {{-22, -38}, {-16, -44}}, lineColor = {0, 0, 255}, lineThickness = 0.5, textString = "3F"), Text(extent = {{-42, -44}, {-36, -50}}, lineColor = {0, 0, 255}, lineThickness = 0.5, textString = "4F"), Line(points = {{20, 0}, {60, 0}}, color = {255, 0, 0}, thickness = 0.5, arrow = {Arrow.Filled, Arrow.None}), Line(points = {{20, -24}, {80, -8}}, color = {0, 0, 255}, thickness = 0.5), Text(extent = {{-40, 8}, {-24, 2}}, lineColor = {0, 0, 255}, lineThickness = 0.5, textString = "Drain"), Text(extent = {{66, -18}, {82, -24}}, lineColor = {0, 0, 255}, lineThickness = 0.5, textString = "Deheating"), Text(extent = {{-36, -18}, {-16, -24}}, lineColor = {0, 0, 255}, lineThickness = 0.5, textString = "Drain cooling"), Line(points = {{-26, 4}, {-22, 0}}, color = {0, 0, 0}, thickness = 0.5, arrow = {Arrow.None, Arrow.Filled}), Line(points = {{-40, -20}, {-40, -40}}, color = {0, 0, 0}, pattern = LinePattern.Dot), Line(points = {{-20, 0}, {-20, -34}}, color = {0, 0, 0}, pattern = LinePattern.Dot), Line(points = {{60, 0}, {60, -14}}, color = {0, 0, 0}, pattern = LinePattern.Dot), Line(points = {{80, 20}, {80, -8}}, color = {0, 0, 0}, pattern = LinePattern.Dot), Text(extent = {{48, 50}, {74, 44}}, lineColor = {0, 0, 255}, textString = "Vapor inlet"), Text(extent = {{-74, 52}, {-48, 46}}, lineColor = {0, 0, 255}, textString = "Drain inlet"), Text(extent = {{-74, -16}, {-48, -22}}, lineColor = {0, 0, 255}, textString = "Drain outlet"), Text(extent = {{-114, 18}, {-88, 12}}, lineColor = {0, 0, 255}, textString = "Water inlet"), Text(extent = {{86, 18}, {112, 12}}, lineColor = {0, 0, 255}, textString = "Water outlet"), Text(extent = {{12, -10}, {34, -18}}, lineColor = {0, 0, 255}, lineThickness = 0.5, textString = "Condensation"), Text(extent = {{-26, -4}, {-12, -8}}, lineColor = {0, 0, 255}, lineThickness = 0.5, textString = "Flash")}),
    Window(x = 0.05, y = 0.01, width = 0.93, height = 0.87),
    Documentation(info = "
## Copyright © EDF 2002 - 2026   
## ThermoSysPro Version 4.2  
This component model is documented in Sect. 9.5.5 of the ThermoSysPro book.   
# NTU water heating  

The static water heater is a two-phase shell-and-tube heat exchanger with three distinct areas. The desuperheating zone and the condensation zone are located in the upper part, and the subcooled zone is in the lower part.  
In some water heaters, the condensate of the water heater located upstream from the current water heater is reinjected into the current water heater. During reinjection, part of the condensate may vaporize due to the pressure drop.  


## Modelica component model  

The equations mentioned below are implemented in the component *NTUWaterHeating*, located in the *WaterSteam.HeatExchangers* sub-library.   
This component has 5 connectors:  
- Ee: water inlet,  
- Se: water outlet  
- Ep: drain inlet,  
- Sp: drain outlet,  
- Ev: vapor inlet.  
   
![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.HeatExchangers.NTUWaterHeating.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.HeatExchangers.NTUWaterHeating.svg)  

## Nomenclature  

| Symbol | Description | Unit | Modelica name |  
| :------------------------ | :----------------------------------------------------------------------------------------------------------------------- | :---------------------------------------- | :----------- |  
|\\\\(c\\_{p, \\mathrm{c}, \\text { cond }}\\\\) | Cold fluid specific heat capacity of the condensation zone |\\\\(\\mathrm{J} / \\mathrm{kg} / \\mathrm{K}\\\\)| promcF.cp |  
|\\\\(c\\_{p, \\mathrm{c}, \\text { des }}\\\\) | Cold fluid specific heat capacity of the desuperheating zone | \\\\(\\mathrm{J} / \\mathrm{kg} / \\mathrm{K}\\\\)| prodesmF.cp |  
|\\\\(c\\_{p, \\text { h,des }}\\\\) | Hot fluid specific heat capacity of the desuperheating zone | \\\\(\\mathrm{J} / \\mathrm{kg} / \\mathrm{K}\\\\)| prodesmC.cp |  
|\\\\(c\\_{p, d, 0}\\\\) | Specific heat capacity of the outlet drain | \\\\(\\mathrm{J} / \\mathrm{kg} / \\mathrm{K}\\\\)| prospC.cp |  
|\\\\(c\\_{p, c, d}\\\\) | Cold fluid specific heat capacity of the subcooled zone | \\\\(\\mathrm{J} / \\mathrm{kg} / \\mathrm{K}\\\\)| prompC.cp |  
|\\\\(h\\_{\\mathrm{c}, \\mathrm{i}}\\\\) | Cold fluid \\(water\\) specific enthalpy at the inlet | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)| Ee.h |  
|\\\\(h\\_{\\mathrm{c}, \\mathrm{o}}\\\\) | Cold fluid \\(water\\) specific enthalpy at the outlet | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)| Se.h |  
|\\\\(h\\_{\\mathrm{c}, \\mathrm{cond}}\\\\) | Cold fluid specific enthalpy at the inlet of the condensation zone | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\) | proeC.h |  
|\\\\(h\\_{\\mathrm{c}, \\mathrm{des}}\\\\) | Cold fluid specific enthalpy at the inlet of the desuperheating zone | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)| prodesF.h |  
|\\\\(h\\_{\\mathrm{d}, \\mathrm{i}}\\\\) | Fluid specific enthalpy of the drain inlet | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)| Ep.h |  
|\\\\(h\\_{\\mathrm{h}, \\mathrm{i}}\\\\) | Hot fluid \\(steam\\) specific enthalpy at the inlet | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)| Ev.h |  
|\\\\(h\\_{\\mathrm{h}, \\mathrm{o}}\\\\) | Hot fluid \\(drain\\) specific enthalpy at the outlet | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)| Sp.h |  
|\\\\(h\\_{\\mathrm{h}, \\mathrm{sub}}\\\\) | Hot fluid specific enthalpy at the inlet of the subcooled zone | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)| prosp.h |  
|\\\\(h\\_{l}^{\\mathrm{sat}}\\\\) | Hot fluid saturation enthalpy of the liquid | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)| lsatC.h |  
|\\\\(h\\_{\\mathrm{v}}^{\\mathrm{sat}}\\\\) | Hot fluid saturation enthalpy of the steam | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)| vsatC.h |  
|\\\\(\\dot{m}\\_{\\mathrm{c}}\\\\) | Cold fluid mass flow rate |\\\\(\\mathrm{kg} / \\mathrm{s}\\\\)| Ee.Q |  
|\\\\(\\dot{m}\\_{\\mathrm{h}}\\\\) | Hot fluid mass flow rate |\\\\(\\mathrm{kg} / \\mathrm{s}\\\\)| Ev.Q |  
|\\\\(m\\_{\\mathrm{d}, \\mathrm{i}}\\\\) | Mass flow rate of the input drain | \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)| Ep.Q |  
|\\\\(m\\_{\\mathrm{d}, \\mathrm{o}}\\\\) | Mass flow rate of the output drain |\\\\(\\mathrm{kg} / \\mathrm{s}\\\\)| Sp.Q |  
|\\\\(P\\_{\\mathrm{c}, \\mathrm{i}}\\\\) | Cold fluid pressure at the inlet |\\\\(\\mathrm{Pa}\\\\)| Ee.P |  
|\\\\(P\\_{\\mathrm{c}, \\mathrm{o}}\\\\) | Cold fluid pressure at the outlet |\\\\(\\mathrm{Pa}\\\\)| Se.P |  
|\\\\(S\\_{\\text {cond }}\\\\) | Exchange surface of the condensation zone | \\\\(\\mathrm{m}^{2}\\\\)| SCondDes |  
|\\\\(S\\_{\\text {des }}\\\\) | Exchange surface of the desuperheating zone|\\\\(\\mathrm{m}^{2}\\\\)| SCondDes |  
|\\\\(S\\_{\\text {liq }}\\\\) | Exchange surface of the subcooled zone |\\\\(\\mathrm{m}^{2}\\\\)| Spurge |  
|\\\\(T\\_{\\mathrm{h}, \\mathrm{i}}\\\\) | Hot fluid \\(steam\\) temperature at the inlet | \\\\(\\mathrm{K}\\\\)| proevC.T |  
|\\\\(T\\_{\\mathrm{h}, \\text { sub }}\\\\) | Hot fluid temperature at the inlet of the subcooled zone | \\\\(\\mathrm{K}\\\\) | prosp.T |  
|\\\\(T\\_{\\text {sat }}\\\\) | Saturation temperature of the hot fluid |\\\\(\\mathrm{K}\\\\)| lsatC.T, vsatC.T |  
\\\\(T\\_{\\mathrm{c}, \\mathrm{i}}\\\\) | Cold fluid \\(water\\) temperature at the inlet | \\\\(\\mathrm{K}\\\\)| proeeF.T |  
|\\\\(T\\_{\\mathrm{c}, \\mathrm{o}}\\\\) | Cold fluid temperature at the outlet | \\\\(\\mathrm{K}\\\\)| proseF.T |  
|\\\\(T\\_{\\mathrm{c}, \\text { cond }}\\\\) | Cold fluid temperature at the inlet of the condensation zone | \\\\(\\mathrm{K}\\\\) | proecF.T |  
|\\\\(T\\_{\\text {c,des }}\\\\) | Cold fluid temperature at the inlet of the desuperheating zone | \\\\(\\mathrm{K}\\\\) | prodesF.T |  
|\\\\(W\\_{\\text {cond }}\\\\) | Thermal power exchanged in the condensation zone | \\\\(\\mathrm{W}\\\\) | Wcond |  
|\\\\(W\\_{\\text {des }}\\\\) | Thermal power exchanged in the desuperheating zone | \\\\(\\mathrm{W}\\\\) | Wdes |  
|\\\\(W\\_{\\text {sub }}\\\\) | Thermal power exchanged in the subcooled zone | \\\\(\\mathrm{W}\\\\) | Wpurge |  
|\\\\(W\\_{\\text {vapo }}\\\\) | Thermal power exchanged for the partial vaporization of the input drain | \\\\(\\mathrm{W}\\\\) | Wflash |  
|\\\\( x\\_{d} \\\\) | Vapor mass fraction in the subcooled zone | \\\\(-\\\\) | prompC.x |  
|\\\\( \\varepsilon\\_{\\text {cond}} \\\\) | NTU effectiveness of the condensation zone | \\\\(-\\\\) | - |  
|\\\\(\\varepsilon\\_{\\text {d}} \\\\) | NTU effectiveness of the subcooled zone | \\\\(-\\\\)| - |  
|\\\\(\\varepsilon\\_{\\text {des}} \\\\) | NTU effectiveness of the desuperheating zone |\\\\(-\\\\)| - |  
| \\\\( \\Lambda \\\\) | Friction pressure loss coefficient for the cold fluid | \\\\(\\mathrm{m}^{-4}\\\\) lambdaE |  
| \\\\( \\rho_c \\\\) | Cold fluid density | \\\\(\\mathrm{kg} / \\mathrm{m}^{3}\\\\)| rho |  


## Governing equations  

### Thermal power exchanged in the desuperheating zone if \\\\(h\\_{\\mathrm{h}, \\mathrm{i}}>h\\_{\\mathrm{v}}^{\\mathrm{sat}}\\\\)  

- Validity domain:   
   
 \\\\(\\dot{m}\\_{\\mathrm{h}}>0\\\\) and \\\\(\\dot{m}\\_{\\mathrm{c}}>0\\\\)  

- Mathematical formulation:   
   
 $$W\\_{\\mathrm{des}} =\\min \\left\\(\\dot{m}\\_{\\mathrm{h}} \\cdot c\\_{p, \\mathrm{h}, \\mathrm{des}}, \\dot{m}\\_{\\mathrm{c}} \\cdot c\\_{p, \\mathrm{c}, \\text { des }}\\right\\) \\cdot \\varepsilon\\_{\\text {des }} \\cdot\\left\\(T\\_{\\mathrm{h}, \\mathrm{i}}-T\\_{\\mathrm{c}, \\text { des }}\\right\\)$$  

- Comments:   
   
 These equations are used only if \\\\(h\\_{\\mathrm{h}, \\mathrm{i}}>h\\_{\\mathrm{v}}^{\\mathrm{sat}}\\\\). If not \\(i.e., for \\\\(\\left.h\\_{\\mathrm{h}, \\mathrm{i}} \\leq h\\_{\\mathrm{v}}^{\\mathrm{sat}}\\right\\),\\\\) then \\\\(W\\_{\\mathrm{des}}=0 .\\\\) The objective of these equations is to compute the desuperheating power \\\\(W\\_{\\text {des}} \\\\) and the specific enthalpy \\\\(h\\_{\\mathrm{c}, \\mathrm{o}}\\\\) of the cold fluid at the outlet.   


### Thermal power exchanged in the condensation zone if \\\\(h\\_{\\mathrm{h}, \\mathrm{i}}>h\\_{\\mathrm{v}}^{\\mathrm{sat}}\\\\)  

- Validity domain:   
   
 \\\\(\\dot{m}\\_{\\mathrm{h}}>0\\\\) and \\\\(\\dot{m}\\_{\\mathrm{c}}>0\\\\)  

- Mathematical formulation:   
   
 $$W\\_{\\text {cond }}=\\dot{m}\\_{\\mathrm{h}} \\cdot\\left\\(h\\_{\\mathrm{v}}^{\\mathrm{sat}}-h\\_{l}^{\\mathrm{sat}}\\right\\)+W\\_{\\mathrm{vapo}} = \\dot{m}\\_{\\mathrm{c}} \\cdot c\\_{p, \\mathrm{c}, \\text { cond }} \\cdot \\varepsilon\\_{\\text {cond }} \\cdot\\left\\(T\\_{\\mathrm{sat}}-T\\_{\\mathrm{c}, \\mathrm{cond}}\\right\\)$$  

- Comments:   
   
 These equations are used only if \\\\(h\\_{\\mathrm{h}, \\mathrm{i}}>h\\_{\\mathrm{v}}^{\\text {sat }}\\(\\mathrm{i.e.},\\\\) presence of a desuperheating zone\\). The objective of these equations is to compute the specific enthalpy \\\\(h\\_{\\mathrm{c}, \\text { des }}\\\\) of the cold fluid at the outlet of this zone and the mass flow rate \\\\(\\dot{m}\\_{\\mathrm{h}}\\\\) of the hot fluid (steam) at the input.  


### Thermal power exchanged in the condensation zone if \\\\(h\\_{\\mathrm{h}, \\mathrm{i}} \\leq h\\_{\\mathrm{v}}^{\\text {sat }}\\\\)  


- Validity domain:   
   
 \\\\(\\dot{m}\\_{\\mathrm{h}}>0\\\\) and \\\\(\\dot{m}\\_{\\mathrm{c}}>0\\\\)  

- Mathematical formulation:   
   
 $$W\\_{\\text {cond }} = \\dot{m}\\_{\\mathrm{c}} \\cdot c\\_{p, \\mathrm{c}, \\text { cond }} \\cdot \\varepsilon\\_{\\text {cond }} \\cdot\\left\\(T\\_{\\mathrm{sat}}-T\\_{\\mathrm{c}, \\mathrm{cond}}\\right\\)$$  

- Comments:   
   
 These equations are used only if \\\\(h\\_{\\mathrm{h}, \\mathrm{i}} \\leq h\\_{\\mathrm{v}}^{\\text {sat }}\\\\) \\(i.e., absence of the desuperheating zone\\). The objective of these equations is to compute the specific enthalpy \\\\(h\\_{\\mathrm{c}, \\text { cond }}\\\\) of the cold fluid at the outlet of this zone and the mass flow rate \\\\(m\\_{\\mathrm{h}}\\\\) of the hot fluid \\(steam\\) at the input.  


### Thermal power exchanged in the drain by partial vaporization (flash)  

- Validity domain:   
   
 \\\\(\\dot{m}\\_{\\mathrm{d}, \\mathrm{i}} \\geq 0\\\\)  

- Mathematical formulation:   
   
 $$W\\_{\\mathrm{vapo}}=\\dot{m}\\_{\\mathrm{d}, \\mathrm{i}} \\cdot x\\_{\\mathrm{d}} \\cdot\\left\\(h\\_{\\mathrm{v}}^{\\mathrm{sat}}-h\\_{l}^{\\mathrm{sat}}\\right\\)$$  

- Comments:   
   
 This equation can also be written as \\\\(W\\_{\\mathrm{vapo}}=\\dot{m}\\_{\\mathrm{d}, \\mathrm{i}} \\cdot\\left\\(h\\_{\\mathrm{d}, \\mathrm{i}}-h\\_{l}^{\\mathrm{sat}}\\right\\)\\\\) \\\\(\\operatorname{since}\\\\) \\\\(\\dot{m}\\_{\\mathrm{d}, \\mathrm{i}} \\cdot h\\_{\\mathrm{d}, \\mathrm{i}}=\\dot{m}\\_{\\mathrm{d}, \\mathrm{i}} \\cdot x\\_{\\mathrm{d}} \\cdot h\\_{\\mathrm{v}}^{\\mathrm{sat}}+\\dot{m}\\_{\\mathrm{d}, \\mathrm{i}} \\cdot\\left\\(1-x\\_{\\mathrm{d}}\\right\\) \\cdot h\\_{l}^{\\mathrm{sat}}\\\\).  


### Energy balance equation at the inlet of the subcooled zone (mixing of the hot fluid with the drain fluid) if \\\\(x\\_{\\mathrm{d}}=0\\\\)  
    

- Validity domain:   
   
 \\\\(\\dot{m}\\_{\\mathrm{d}, \\mathrm{o}} \\neq 0\\\\)  

- Mathematical formulation:   
   
 $$\\dot{m}\\_{\\mathrm{d}, \\mathrm{o}} \\cdot h\\_{\\mathrm{h}, \\mathrm{sub}}=\\dot{m}\\_{\\mathrm{h}} \\cdot h\\_{l}^{\\mathrm{sat}}+\\dot{m}\\_{\\mathrm{d}, \\mathrm{i}} \\cdot h\\_{\\mathrm{d}, \\mathrm{i}}$$  

- Comments:   
   
 The objective of this equation is to compute the specific enthalpy \\\\(h\\_{\\mathrm{h}, \\text { sub }}\\\\) at the inlet of the subcooled zone for the hot fluid. If \\\\(x\\_{\\mathrm{d}}>0,\\\\) then \\\\(h\\_{\\mathrm{h}, \\text { sub }}=h\\_{l}^{\\mathrm{sat}}\\\\).  


### Energy balance equation for subcooled zone (drain cooling) if \\\\(S\\_{\\text {liq }}>0\\\\)  


- Validity domain:  

\\\\(\\dot{m}\\_{\\mathrm{c}}>0\\\\) and \\\\(\\dot{m}\\_{\\mathrm{d}, \\mathrm{o}}>0\\\\)  

- Mathematical formulation:   

$$ W\\_{\\mathrm{sub}} =  \\min \\left\\(\\dot{m}\\_{\\mathrm{d}, \\mathrm{o}} \\cdot c\\_{p, \\mathrm{d}, 0}, \\dot{m}\\_{\\mathrm{c}} \\cdot c\\_{p, \\mathrm{c}, \\mathrm{d}}\\right\\) \\cdot \\varepsilon\\_{\\mathrm{d}} \\cdot\\left\\(T\\_{\\mathrm{h}, \\mathrm{sub}}-T\\_{\\mathrm{c}, \\mathrm{i}}\\right\\) $$  

- Comments:  

 If \\\\(S\\_{\\mathrm{liq}}=0,\\\\) then \\\\(W\\_{\\mathrm{sub}}=0\\\\) and  
\\\\(h\\_{\\mathrm{h}, \\mathrm{o}}=h\\_{\\mathrm{h}, \\text { sub }}\\\\).  

### Mass balance equation for the hot fluid (mixing of the hot fluid with the drain fluid)   


    
    

- Validity domain:   
   
 \\\\(\\dot{m}\\_{\\mathrm{h}}>0\\\\) and \\\\(\\dot{m}\\_{\\mathrm{d}, \\mathrm{i}} \\geq 0\\\\)  


- Mathematical formulation:  

$$\\dot{m}\\_{\\mathrm{d}, \\mathrm{o}}=\\dot{m}\\_{\\mathrm{h}}+\\dot{m}\\_{\\mathrm{d}, \\mathrm{i}}$$  

- Comments:  



### Momentum balance equation for the cold fluid (pressure loss equation in the water pipes)  
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\_{\\mathrm{c}}\\\\)  

- Mathematical formulation:   
   
 $$P\\_{\\mathrm{c}, \\mathrm{i}}-P\\_{\\mathrm{c}, \\mathrm{o}} = \\Lambda \\cdot \\frac{\\dot{m}\\_{\\mathrm{c}} \\cdot \\dot{m}\\_{\\mathrm{c}}}{\\rho\\_{\\mathrm{c}}}$$  

- Comments:   
   
 Only pressure losses due friction are taken into account.  

## References   
   
El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 9.5.5. Springer Nature Switzerland AG.  
    ", revisions = "
Author  

Baligh El Hefni   

    "),
    DymolaStoredErrors);
end NTUWaterHeating;