within ThermoSysPro.WaterSteam.HeatExchangers;

model StaticWaterWaterExchanger "Static plate heat exchanger"
  parameter Units.SI.ThermalConductivity lambdam = 15.0 "Metal thermal conductivity";
  parameter Units.SI.CoefficientOfHeatTransfer p_hc = 6000 "Heat transfer coefficient for the hot side if not computed by the correlations";
  parameter Units.SI.CoefficientOfHeatTransfer p_hf = 3000 "Heat transfer coefficient for the cold side if not computed by the correlations";
  parameter Real p_Kc = 100 "Pressure loss coefficient for the hot side if not computed by the correlations";
  parameter Real p_Kf = 100 "Pressure loss coefficient for the cold side if not computed by the correlations";
  parameter Units.SI.Thickness emetal = 0.0006 "Wall thickness";
  parameter Units.SI.Area Sp = 2 "Plate area";
  parameter Real nbp = 499 "Number of plates";
  parameter Real c1 = 1.12647 "Correction coefficient";
  parameter Units.SI.Density p_rhoc = 0 "If > 0, fixed fluid density for the hot fluid";
  parameter Units.SI.Density p_rhof = 0 "If > 0, fixed fluid density for the cold fluid";
  parameter Integer modec = 0 "IF97 region for the hot fluid. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer modef = 0 "IF97 region for the cold fluid. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer exchanger_type = 1 "Exchanger type - 1: countercurrent. 2: cocurrent";
  parameter Integer heat_exchange_correlation = 1 "Correlation for the computation of the heat exchange coefficient - 0: no correlation. 1: SRI correlations";
  parameter Integer pressure_loss_correlation = 1 "Correlation for the computation of the pressure loss coefficient - 0: no correlation. 1: SRI correlations";
  Units.SI.Power W "Thermal power exchanged between the two sides";
  ThermoSysPro.Units.SI.PressureDifference DPc "Pressure loss of the hot fluid";
  ThermoSysPro.Units.SI.PressureDifference DPf "Pressure loss of the cold fluid";
  Units.SI.CoefficientOfHeatTransfer hc "Heat transfer coefficient of the hot fluid";
  Units.SI.CoefficientOfHeatTransfer hf "Heat transfer coefficient of the cold fluid";
  Units.SI.CoefficientOfHeatTransfer K "Global heat transfer coefficient";
  Units.SI.Area S "Heat exchange surface";
  Units.SI.Temperature Tec "Fluid temperature at the hot inlet";
  Units.SI.Temperature Tsc "Fluid temperature at the hot outlet";
  Units.SI.Temperature Tef "Fluid temperature at the cold inlet";
  Units.SI.Temperature Tsf "Fluid temperature at the cold outlet";
  ThermoSysPro.Units.SI.TemperatureDifference DTm "Difference in average temperature";
  ThermoSysPro.Units.SI.TemperatureDifference DT1 "Temperature difference at the inlet of the exchanger";
  ThermoSysPro.Units.SI.TemperatureDifference DT2 "Temperature difference at the outlet of the exchanger";
  Real DT12 "DT1/DT2 (s.u.)";
  Units.SI.MassFlowRate Qc(start = 500) "Mass flow rate of the hot fluid";
  Units.SI.MassFlowRate Qf(start = 500) "Mass flow rate of the cold fluid";
  Real qmc;
  Real qmf;
  Real quc;
  Real quf;
  Real N;
  Units.SI.Density rhoc(start = 998) "Hot fluid density";
  Units.SI.Density rhof(start = 998) "Cold fluid density";
  Units.SI.DynamicViscosity muc(start = 1.e-3) "Hot fluid dynamic viscosity";
  Units.SI.DynamicViscosity muf(start = 1.e-3) "Cold fluid dynamic viscosity";
  Units.SI.ThermalConductivity lambdac(start = 0.602698) "Hot fluid thermal conductivity";
  Units.SI.ThermalConductivity lambdaf(start = 0.597928) "Cold fluid thermal conductivity";
  Units.SI.Temperature Tmc(start = 290) "Hot fluid average temperature";
  Units.SI.Temperature Tmf(start = 290) "Cold fluid average temperature";
  Units.SI.AbsolutePressure Pmc(start = 1.e5) "Hot fluid average pressure";
  Units.SI.AbsolutePressure Pmf(start = 1.e5) "Cold fluid average pressure";
  Units.SI.SpecificEnthalpy Hmc(start = 100000) "Hot fluid average specific enthalpy";
  Units.SI.SpecificEnthalpy Hmf(start = 100000) "Cold fluid average specific enthalpy";
  Connectors.FluidInlet Ec annotation(
    Placement(transformation(extent = {{-110, -10}, {-90, 10}}, rotation = 0)));
  Connectors.FluidInlet Ef annotation(
    Placement(transformation(extent = {{-60, -70}, {-40, -50}}, rotation = 0)));
  Connectors.FluidOutlet Sf annotation(
    Placement(transformation(extent = {{40, -70}, {60, -50}}, rotation = 0)));
  Connectors.FluidOutlet Sc annotation(
    Placement(transformation(extent = {{90, -8}, {110, 12}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proce annotation(
    Placement(transformation(extent = {{-60, 80}, {-40, 100}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph procs annotation(
    Placement(transformation(extent = {{-20, 80}, {0, 100}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph profe annotation(
    Placement(transformation(extent = {{-60, -100}, {-40, -80}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph profs annotation(
    Placement(transformation(extent = {{-20, -100}, {0, -80}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proc annotation(
    Placement(transformation(extent = {{-100, 80}, {-80, 100}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prof annotation(
    Placement(transformation(extent = {{-100, -100}, {-80, -80}}, rotation = 0)));
equation
/* Mass flow rates */
  Ec.Q = Sc.Q;
  Ef.Q = Sf.Q;
  Qc = Ec.Q;
  Qf = Ef.Q;
/* Pressures */
  Sc.P = if Qc > 0 then Ec.P - DPc else Ec.P + DPc;
  Sf.P = if Qf > 0 then Ef.P - DPf else Ef.P + DPf;
/* Flow reversal */
  0 = if (Qc > 0) then Ec.h - Ec.h_vol else Sc.h - Sc.h_vol;
  0 = if (Qf > 0) then Ef.h - Ef.h_vol else Sf.h - Sf.h_vol;
/* Heat exchanges between the hot and cold fluids */
  K = hc*hf/(hc + hf + hc*hf*emetal/lambdam);
  W = K*S*DTm;
  if (abs(Qc) > 1.e-3) then
    W = Qc*proc.cp*(Tec - Tsc);
  else
    Tec = Tsc;
  end if;
  if (abs(Qf) > 1.e-3) then
    W = Qf*prof.cp*(Tsf - Tef);
  else
    Tef = Tsf;
  end if;
/* Difference in average temperatures */
  if noEvent(((DT1 > DT2) and (DT2 > 0)) or ((DT1 < DT2) and (DT2 < 0))) then
    DTm = (DT1 - DT2)/Modelica.Math.log(DT1/DT2);
  else
    DTm = (DT1 + DT2)/2;
  end if;
  if (exchanger_type == 1) then
/* Counter-current heat exchanger */
    DT1 = Tec - Tsf;
    DT2 = Tsc - Tef;
  elseif (exchanger_type == 2) then
/* Co-current heat exchanger */
    DT1 = Tec - Tef;
    DT2 = Tsc - Tsf;
  else
    DT1 = 0;
    DT2 = 0;
    assert(false, "StaticWaterWaterExchanger: incorrect exchanger type");
  end if;
  DT12 = if noEvent(abs(DT2) > Modelica.Constants.eps) then DT1/DT2 else 0;
/* Heat exchange area (for the plate heat exchanger) */
  S = (nbp - 2)*Sp;
  N = (nbp - 1)/2;
/* Heat exchange coefficients */
  qmc = noEvent(abs(Qc)/(muc*N));
  qmf = noEvent(abs(Qf)/(muf*N));
  if (heat_exchange_correlation == 0) then
    hc = p_hc;
    hf = p_hf;
  elseif (heat_exchange_correlation == 1) then
    hc = noEvent(if (qmc < 1.e-3) then 0 else 11.245*qmc^0.8*abs(muc*proc.cp/lambdac)^0.4*lambdac);
    hf = noEvent(if (qmf < 1.e-3) then 0 else 11.245*qmf^0.8*abs(muf*prof.cp/lambdaf)^0.4*lambdaf);
  else
    hc = 0;
    hf = 0;
    assert(false, "StaticWaterWaterExchanger: incorrect heat exchange correlation number");
  end if;
/* Pressure losses */
  quc = noEvent(abs(Qc)/N);
  quf = noEvent(abs(Qf)/N);
  if (pressure_loss_correlation == 0) then
    DPc = p_Kc*Qc^2/rhoc;
    DPf = p_Kf*Qf^2/rhof;
  elseif (pressure_loss_correlation == 1) then
    DPc = noEvent(if (qmc < 1.e-3) then 0 else c1*14423.2/rhoc*qmc^(-0.097)*quc^2*(1472.47 + 1.54*(N - 1)/2 + 104.97*qmc^(-0.25)));
    DPf = noEvent(if (qmf < 1.e-3) then 0 else 14423.2/rhof*qmf^(-0.097)*quf^2*(1472.47 + 1.54*(N - 1)/2 + 104.97*qmf^(-0.25)));
  else
    DPc = 0;
    DPf = 0;
    assert(false, "StaticWaterWaterExchanger: incorrect pressure loss correlation number");
  end if;
/* Fluid thermodynamic properties */
  Pmc = (Ec.P + Sc.P)/2;
  Pmf = (Ef.P + Sf.P)/2;
  Hmc = (Ec.h + Sc.h)/2;
  Hmf = (Ef.h + Sf.h)/2;
  proc = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Pmc, Hmc, modec);
  prof = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Pmf, Hmf, modef);
  Tmc = proc.T;
  Tmf = prof.T;
  if (p_rhoc > 0) then
    rhoc = p_rhoc;
  else
    rhoc = proc.d;
  end if;
  if (p_rhof > 0) then
    rhof = p_rhof;
  else
    rhof = prof.d;
  end if;
  muc = ThermoSysPro.Properties.WaterSteam.IF97.DynamicViscosity_rhoT(rhoc, Tmc);
  muf = ThermoSysPro.Properties.WaterSteam.IF97.DynamicViscosity_rhoT(rhof, Tmf);
  lambdac = ThermoSysPro.Properties.WaterSteam.IF97.ThermalConductivity_rhoT(rhoc, Tmc, Pmc);
  lambdaf = ThermoSysPro.Properties.WaterSteam.IF97.ThermalConductivity_rhoT(rhof, Tmf, Pmf);
/* Calcul des températures en entrée et en sortie de l'échangeur */
  proce = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Ec.P, Ec.h, modec);
  procs = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Sc.P, Sc.h, modec);
  profe = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Ef.P, Ef.h, modef);
  profs = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Sf.P, Sf.h, modef);
  Tec = proce.T;
  Tsc = procs.T;
  Tef = profe.T;
  Tsf = profs.T;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Rectangle(extent = {{-100, 60}, {100, -60}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Line(points = {{-80, 60}, {-80, -60}}), Line(points = {{80, 60}, {80, -60}}), Line(points = {{-80, 0}, {-60, 0}, {-40, 20}, {40, -20}, {60, 0}, {80, 0}}, color = {0, 0, 255})}),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Rectangle(extent = {{-100, 60}, {100, -60}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Line(points = {{-80, 60}, {-80, -60}}), Line(points = {{80, 60}, {80, -60}}), Line(points = {{-80, 0}, {-60, 0}, {-40, 20}, {40, -20}, {60, 0}, {80, 0}}, color = {0, 0, 255})}),
    Window(x = 0.05, y = 0.01, width = 0.93, height = 0.87),
    Documentation(info = "
## Copyright © EDF 2002 - 2026  
## ThermoSysPro Version 4.2  
This component model is documented in Sect. 9.6.2 of the ThermoSysPro book.   
# Static water water exchanger   
   
This static plate heat exchanger is the steady-state version of the [dynamic water water exchanger](modelica://ThermoSysPro.WaterSteam.HeatExchangers.DynamicWaterWaterExchanger).  
In addition to the [dynamic model](modelica://ThermoSysPro.WaterSteam.HeatExchangers.DynamicWaterWaterExchanger) assumptions, the specific heats and mass flow rates of both fluids are supposed constant.  


## Modelica component model  

The equations mentioned below are implemented in the component *StaticWaterWaterExchanger*, located in the *WaterSteam.HeatExchangers* sub-library.   
   
![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.HeatExchangers.StaticWaterWaterExchanger.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.HeatExchangers.StaticWaterWaterExchanger.svg)  

## Nomenclature  

| Symbol| Description| Unit| Definition| Modelica name |  
| :----------------------------------- | :------------------------------------------------------------------------------------------- | :------------------------------------------- | :---------------------------------------------------------------------- | :----------- |  
| \\\\(A\\\\)| Heat exchange surface| \\\\(\\mathrm{m}^{2}\\\\)| \\\\(\\left\\(N\\_{\\mathrm{p}}-2\\right\\) \\cdot S\\_{\\mathrm{p}}\\\\)| S |  
| \\\\(m\\_{\\mathrm{h}}\\\\)| Hot fluid mass flow rate| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Qc |  
| \\\\(m\\_{\\mathrm{c}}\\\\)| Cold fluid mass flow rate| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Qf |  
| \\\\(N\\_{\\mathrm{c}}\\\\)| Number of channels of each fluid| \\\\(-\\\\)| \\\\(\\left\\(N\\_{\\mathrm{p}}-1\\right\\) / 2\\\\)| N |  
| \\\\(N\\_{\\mathrm{p}}\\\\)| Number of plates| \\\\(-\\\\)|| nbp |  
| \\\\(P\\_{\\mathrm{c}, \\mathrm{i}}\\\\) | Cold fluid pressure at the inlet| \\\\(\\mathrm{Pa}\\\\)|| Ef.P |  
| \\\\(P\\_{\\mathrm{c}, \\mathrm{o}}\\\\) | Cold fluid pressure at the outlet| \\\\(\\mathrm{Pa}\\\\)|| Sf.P |  
| \\\\(P\\_{\\mathrm{h}, \\mathrm{i}}\\\\) | Hot fluid pressure at the inlet| \\\\(\\mathrm{Pa}\\\\)|| Ec.P |  
| \\\\(P\\_{\\mathrm{h}, \\mathrm{o}}\\\\) | Hot fluid pressure at the outlet| \\\\(\\mathrm{Pa}\\\\)|| Sc.P |  
| \\\\(T\\_{\\mathrm{c}, \\mathrm{i}}\\\\) | Cold fluid temperature at the inlet| \\\\(\\mathrm{K}\\\\)|| Tef |  
| \\\\(T\\_{\\mathrm{c}, \\mathrm{o}}\\\\) | Cold fluid temperature at the outlet| \\\\(\\mathrm{K}\\\\)|| Tsf |  
| \\\\(T\\_{\\mathrm{h}, \\mathrm{i}}\\\\) | Hot fluid temperature at the inlet| \\\\(\\mathrm{K}\\\\)|| Tec |  
| \\\\(T\\_{\\mathrm{h}, \\mathrm{o}}\\\\) | Hot fluid temperature at the outlet| \\\\(\\mathrm{K}\\\\)|| Tsc |  
| \\\\(U\\\\)| Global heat transfer coefficient \\(internal overall heat exchange coefficient\\)| \\\\(\\mathrm{W} / \\mathrm{m}^{2} / \\mathrm{K}\\\\) || K |  
| \\\\(W\\\\)| Thermal power exchanged between the two fluids| \\\\(\\mathrm{W}\\\\)|| W |  
| \\\\(\\Delta T\\_{1}\\\\)| Temperature difference 1| \\\\(\\mathrm{K}\\\\)| For counter flow \\\\(T\\_{\\mathrm{h}, \\mathrm{i}}-T\\_{\\mathrm{c}, \\mathrm{o}}\\\\) For parallel flow \\\\(T\\_{\\mathrm{h}, \\mathrm{i}}-T\\_{\\mathrm{c}, \\mathrm{i}}\\\\) | DT1 |  
| \\\\(\\Delta T\\_{2}\\\\)| Temperature difference 2| \\\\(\\mathrm{K}\\\\)| For counter flow \\\\(T\\_{\\mathrm{h}, \\mathrm{o}}-T\\_{\\mathrm{c}, \\mathrm{i}}\\\\) For parallel flow \\\\(T\\_{\\mathrm{h}, \\mathrm{o}}-T\\_{\\mathrm{c}, \\mathrm{o}}\\\\) | DT2 |  
| \\\\(\\Lambda\\_{\\mathrm{c}}\\\\)| Friction pressure loss coefficient of the entire length of the exchanger for the cold fluid | \\\\(\\mathrm{m}^{-4}\\\\)|| p_Kf |  
| \\\\(\\Lambda\\_{\\mathrm{h}}\\\\)| Friction pressure loss coefficient of the entire length of the exchanger for the hot fluid| \\\\(\\mathrm{m}^{-4}\\\\)|| p_Kc |  
| \\\\(\\rho\\_{\\mathrm{c}}\\\\)| Cold fluid density| \\\\(\\mathrm{kg} / \\mathrm{m}^{3}\\\\)|| rhof |  
| \\\\(\\rho\\_{\\mathrm{h}}\\\\)| Hot fluid density| \\\\(\\mathrm{kg} / \\mathrm{m}^{3}\\\\)|| rhoc |  



## Governing equations  

### Energy balance equation \\(hot fluid\\)  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\_{\\mathrm{h}}\\\\)  

- Mathematical formulation:   
   
 $$W=\\dot{m}\\_{\\mathrm{h}} \\cdot c\\_{p, \\mathrm{h}} \\cdot\\left\\(T\\_{\\mathrm{h}, \\mathrm{i}}-T\\_{\\mathrm{h}, \\mathrm{o}}\\right\\)$$  


### Energy balance equation \\(cold fluid\\)  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\_{\\mathrm{c}}\\\\)  

- Mathematical formulation:   
   
 $$W=\\dot{m}\\_{\\mathrm{c}} \\cdot c\\_{p, \\mathrm{c}} \\cdot\\left\\(T\\_{\\mathrm{c}, \\mathrm{o}}-T\\_{\\mathrm{c}, \\mathrm{i}}\\right\\)$$  


### Heat exchanged between the fluid and the wall  


    
    

- Validity domain:   
   
 \\\\(\\dot{m}\\_{\\mathrm{h}} \\neq 0, \\dot{m}\\_{\\mathrm{c}} \\neq 0, \\Delta T\\_{1} \\neq 0\\\\) and \\\\(\\Delta T\\_{2} \\neq 0\\\\)  

- Mathematical formulation:   
   
 $$W=U \\cdot A \\cdot \\frac{\\Delta T\\_{2}-\\Delta T\\_{1}}{\\ln \\left\\(\\frac{\\Delta T\\_{2}}{\\Delta T\\_{1}}\\right\\)}$$  

- Comments:   
   



### Momentum balance equation \\(hot fluid\\)  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\_{\\mathrm{h}}\\\\)  

- Mathematical formulation:   
   
 $$P\\_{\\mathrm{h}, \\mathrm{o}}=P\\_{\\mathrm{h}, \\mathrm{i}}-\\Lambda\\_{\\mathrm{h}} \\cdot \\frac{\\dot{m}\\_{\\mathrm{h}} \\cdot \\lvert \\dot{m}\\_{\\mathrm{h}}\\rvert}{N\\_{\\mathrm{c}}^{2} \\cdot \\rho\\_{\\mathrm{h}}}$$  

- Comments:   
   



### Momentum balance equation \\(cold fluid\\)  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\_{\\mathrm{c}}\\\\)  

- Mathematical formulation:   
   
 $$P\\_{\\mathrm{c}, \\mathrm{o}}=P\\_{\\mathrm{c}, \\mathrm{i}}-\\Lambda\\_{\\mathrm{c}} \\cdot \\frac{\\dot{m}\\_{\\mathrm{c}} \\cdot \\lvert \\dot{m}\\_{\\mathrm{c}}\\rvert }{N\\_{\\mathrm{c}}^{2} \\cdot \\rho\\_{\\mathrm{c}}}$$  

- Comments:   
   


## References   
   
El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 9.6.2. Springer Nature Switzerland AG.  
    ", revisions = "
Author  

Daniel Bouskela   

    "));
end StaticWaterWaterExchanger;