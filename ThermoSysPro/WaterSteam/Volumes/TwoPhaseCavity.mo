within ThermoSysPro.WaterSteam.Volumes;

model TwoPhaseCavity "TwoPhaseCavity for one shell pass "
  parameter Boolean Vertical = true "true: vertical cylinder - false: horizontal cylinder";
  parameter Units.SI.Radius R = 1.05 "Radius of the Cavity cross-sectional area";
  parameter Units.SI.Length Lc = 2.5 "support plate spacing in cooling zone(Chicanes)";
  parameter Units.SI.Volume V = 50 "Cavity volume ( total volume + bleedings volume - pipes volume) ";
  parameter Units.SI.Volume Vmin = 1.e-6;
  parameter Real Vf0 = 0.5 "Fraction of initial water volume in the Cavity (active if steady_state=false)";
  parameter Integer Ns = 10 "Number of segments for one tube pass";
  parameter Integer NbTub1 = 500 "Numbers of drowned pipes in liquid; Pipe 1 (Hoizontal, Vertical Separate)";
  parameter Integer NbTub2 = 500 "Number of total pipes immersed in steam = NbTub2; Pipe 2";
  parameter Integer NbTub3 = 2000 "Number of total pipes immersed in steam ; Pipe 3";
  parameter Integer NbTubV = 15 "Numbers of pipes in a vertical row (tube bank)";
  parameter Units.SI.Length L1 = 10 " Length of drowned pipes in liquid (pipes 1)";
  parameter Units.SI.Length L2 = 10 " Length of Pipe 2 (in steam)";
  parameter Units.SI.Length L3 = 20 " Length of Pipe 3 (in steam)";
  parameter Units.SI.Diameter Dext = 0.02 "External pipe diameter";
  parameter Units.SI.Diameter DIc = 1.40 "Internal calendre diameter";
  parameter Units.SI.Length PasL = 0.025 "Longitudianl step or Length bottom pipes triangular step";
  parameter Units.SI.Length PasT = 0.023 " Transverse step or pipes step";
  //parameter ThermoSysPro.Units.SI.Angle Angle = 60 "Average bend angle (deg)";
  parameter ThermoSysPro.Units.nonSI.Angle_deg Angle = 60 "Average bend angle (deg)";
  parameter Units.SI.Pressure P0 = 1e5 "Fluid initial pressure (active if steady_state=false)";
  parameter Real Ccond = 0.01 "Condensation coefficient";
  parameter Real Cevap = 0.09 "Evaporation coefficient";
  parameter Real Xlo = 0.0025 "Vapor mass fraction in the liquid phase from which the liquid starts to evaporate";
  parameter Real Xvo = 0.9975 "Vapor mass fraction in the gas phase from which the liquid starts to condensate";
  //parameter Real Kvl=1000
  // "Heat exchange coefficient between the liquid and gas phases";
  parameter Boolean steady_state = true "true: start from steady state - false: start from (P0, Vl0)";
  parameter Real COPv(start = 1) = 1 "Corrective terme for Heat exchange coefficient or Fouling coefficient steam side";
  parameter Real COPl(start = 1) = 1 "Corrective terme for Heat exchange coefficient or Fouling coefficient liquid side";
  parameter Boolean Cal_hconv = true "false : heat transfer coefficient liquid and steam = parameter  - true: calculate by Nusselt corelation";
  parameter Units.SI.CoefficientOfHeatTransfer hliq = 1.5e3 "Heat transfer coefficient between the liquid and the cooling pipes ";
  parameter Units.SI.CoefficientOfHeatTransfer hcond = 8e3 "Heat transfer coefficient between the vapor and the cooling pipes ";
  parameter Units.SI.CoefficientOfHeatTransfer Kvl = 1000 "Heat exchange coefficient between the liquid and gas phases";
  parameter Units.SI.CoefficientOfHeatTransfer Klp = 850 "Heat exchange coefficient between the liquid phase and the wall";
  parameter Units.SI.CoefficientOfHeatTransfer Kvp = 450 "Heat exchange coefficient between the gas phase and the wall";
  parameter Units.SI.CoefficientOfHeatTransfer Kpa = 0.5 "Heat exchange coefficient between the wall and the outside ambiant";
  parameter Units.SI.Temperature Ta = 310 "External temperature";
  parameter Units.SI.Mass Mp = 100e3 "Wall mass";
  parameter Units.SI.SpecificHeatCapacity cpp = 600 "Wall specific heat";
  //***********************************
  parameter Boolean step_square = true "true: Aligned pipes   - false: staggered pipes (Step triangular)";
  //protected
  constant Units.SI.Acceleration g = Modelica.Constants.g_n "Gravity constant";
  constant Real pi = Modelica.Constants.pi;
  parameter Integer Ns3 = 2*Ns "Number of segments for half pipes";
  //parameter ThermoSysPro.Units.SI.PathLength Ls1=L1/Ns "Section length for one pass pipe";
  parameter Units.SI.CoefficientOfHeatTransfer h4 = 1 "h4 = 1, Heat exchange coefficient";
  parameter Units.SI.Area S4 = 1 " S4 = 1, Heat exchange surface  ";
  Units.SI.Length L(start = 15) "Cavity length";
  Integer NbTubT "Number of total pipes in Cavity";
  Units.SI.Pressure P "Fluid average pressure";
  Units.SI.Pressure Pfond "Fluid pressure at the bottom of the cavity";
  Units.SI.SpecificEnthalpy hl "Liquid phase spepcific enthalpy";
  //ThermoSysPro.Units.SI.SpecificEnthalpy hl0 "Liquid phase spepcific enthalpy";
  Units.SI.SpecificEnthalpy hv "Gas phase spepcific enthalpy";
  Units.SI.Temperature Tl "Liquid phase temperature";
  Units.SI.Temperature Tv "Gas phase temperature";
  Units.SI.Volume Vl "Liquid phase volume";
  Units.SI.Volume Vv "Gas phase volume";
  Real xl(start = 0.5) "Mass vapor fraction in the liquid phase";
  Real xv(start = 0) "Mass vapor fraction in the gas phase";
  Units.SI.Density rhol(start = 996) "Liquid phase density";
  Units.SI.Density rhov(start = 1.5) "Gas phase density";
  Units.SI.MassFlowRate BQl "Right hand side of the mass balance equation of the liquid phase";
  Units.SI.MassFlowRate BQv "Right hand side of the mass balance equation of the gas phaser";
  Units.SI.Power BHl "Right hand side of the energy balance equation of the liquid phase";
  Units.SI.Power BHv "Right hand side of the energy balance equation of the gas phase";
  Units.SI.MassFlowRate Qcond "Condensation mass flow rate from the vapor phase";
  Units.SI.MassFlowRate Qevap "Evaporation mass flow rate from the liquid phase";
  Real QS "Surface mass flow rate of Water (kg/m2s)";
  //Real QSm "Surface mass flow rate maximal of Water (kg/m2s)";
  Units.SI.Power dW1[Ns](start = fill(10e5, Ns)) "Power exchange between the wall and the fluid in each section side 1";
  Units.SI.Power dW2[Ns](start = fill(10e5, Ns)) "Power exchange between the wall and the fluid in each section side 2";
  Units.SI.Power dW3[Ns3](start = fill(10e5, Ns3)) "Power exchange between the wall and the fluid in each section side 3";
  Units.SI.Power W1t "Total power exchanged on the steam side 1";
  Units.SI.Power W2t "Total power exchanged on the water side 2";
  Units.SI.Power W3t "Total power exchanged on the water side 3";
  Units.SI.Power W4t "Total power exchanged on the steam side 4";
  Units.SI.Power Wvl "Thermal power exchanged from the gas phase to the liquid phase";
  Units.SI.Power Wpl "Thermal power exchanged from the liquid phase to the wall";
  Units.SI.Power Wpv "Thermal power exchanged from the gas phase to the wall";
  Units.SI.Power Wpa "Thermal power losses to ambiant";
  Units.SI.Temperature Tp1[Ns](start = fill(400, Ns)) "Wall temperature in section i of side 1";
  Units.SI.Temperature Tp2[Ns](start = fill(400, Ns)) "Wall temperature in section i of side 2";
  Units.SI.Temperature Tp3[Ns3](start = fill(400, Ns3)) "Wall temperature in section i of side 3";
  Units.SI.Temperature Tp(start = 400) "Wall temperature of cavity";
  Units.SI.Position zl(start = 1.05) "Liquid level in Cavity";
  Units.SI.Area Al(start = 5) "Cross sectional area of the liquid phase";
  Units.SI.Angle theta "Angle";
  Units.SI.Area Avl(start = 5) "Heat exchange surface between the liquid and gas phases";
  Units.SI.Area Alp "Liquid phase surface on contact with the wall";
  Units.SI.Area Avp "Gas phase surface on contact with the wall";
  Units.SI.Area Ape "Wall surface on contact with the fluid";
  Units.SI.Area Surf_tot(start = 1.e4) "Total heat exchange surface";
  Units.SI.Area Surf_ext1(start = 1.e2) "Heat exchange surface for drowned section ; pipe 1";
  Units.SI.Area Surf_ext2(start = 1.e2) "Heat exchange surface for section 2 ; pipe 2 ";
  Units.SI.Area Surf_ext3(start = 1.e2) "Heat exchange surface for section 3 ; pipe 3";
  //ThermoSysPro.Units.SI.ReynoldsNumber Rel (start= 6.e4)  "liquid Reynolds number";
  Units.SI.ReynoldsNumber Rel(start = 6.e4) "liquid Reynolds number";
  // ThermoSysPro.Units.SI.ReynoldsNumber Rev( start= 6.e3) "Steam Reynolds number";
  Real Prl(start = 1) "liquid Prandtl number in node i";
  Units.SI.ThermalConductivity kl(start = 1) "liquid thermal conductivity";
  Units.SI.DynamicViscosity mul(start = 2.e-4) "liquid dynamic viscosity ";
  Units.SI.DynamicViscosity mult[Ns](start = fill(2.e-4, Ns)) "liquid dynamic viscosity at wall temperature";
  Units.SI.CoefficientOfHeatTransfer hcond2[Ns](start = fill(1e4, Ns)) "Heat transfer coefficient between the vapor and the cooling pipes zone 2";
  Units.SI.CoefficientOfHeatTransfer hcond3[Ns3](start = fill(1e4, Ns3)) "Heat transfer coefficient between the vapor and the cooling pipes zone 3";
  Units.SI.CoefficientOfHeatTransfer hliqu[Ns](start = fill(1000, Ns)) "Heat transfer coefficient between the liquid and the cooling pipes zone 1";
  Units.SI.Diameter DH(start = 0.02) "hydraulic diameter";
  Real EE[Ns](start = fill(1, Ns));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prol "Propriétés de l'eau dans le ballon" annotation(
    Placement(transformation(extent = {{-250, 70}, {-210, 110}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prov "Propriétés de la vapeur dans le ballon" annotation(
    Placement(transformation(extent = {{60, 70}, {100, 110}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat lsat annotation(
    Placement(transformation(extent = {{-250, -200}, {-210, -160}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat vsat annotation(
    Placement(transformation(extent = {{58, -200}, {98, -160}}, rotation = 0)));
  Connectors.FluidInlet Cv "Steam input" annotation(
    Placement(transformation(extent = {{-86, 50}, {-66, 70}}, rotation = 0)));
  Connectors.FluidOutlet Cl "Water output" annotation(
    Placement(transformation(extent = {{-86, -170}, {-66, -150}}, rotation = 0)));
  ThermoSysPro.Thermal.Connectors.ThermalPort Cth3[Ns3] annotation(
    Placement(transformation(extent = {{-59, -37}, {-47, -25}}, rotation = 0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal yLevel "Water level" annotation(
    Placement(transformation(extent = {{90, -105}, {110, -85}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prod annotation(
    Placement(transformation(extent = {{-250, -20}, {-210, 20}}, rotation = 0)));
  Connectors.FluidInlet Ce "Water input" annotation(
    Placement(transformation(extent = {{-160, 50}, {-140, 70}}, rotation = 0)));
  ThermoSysPro.Thermal.Connectors.ThermalPort Cth1[Ns] annotation(
    Placement(transformation(extent = {{-59, -103}, {-47, -90}}, rotation = 0)));
  ThermoSysPro.Thermal.Connectors.ThermalPort Cth2[Ns] annotation(
    Placement(transformation(extent = {{-59, 35}, {-47, 48}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proe annotation(
    Placement(transformation(extent = {{-250, -110}, {-210, -70}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph provIn "Propriétés de la vapeur dans le ballon" annotation(
    Placement(transformation(extent = {{12, 70}, {52, 110}}, rotation = 0)));
initial equation
  if steady_state then
    der(hl) = 0;
    der(hv) = 0;
    der(Vl) = 0;
    der(P) = 0;
    der(Tp) = 0;
  else
    hl = lsat.h;
    hv = vsat.h;
    Vl = Vf0*V;
    P = P0;
    der(Tp) = 0;
  end if;
equation
/* Unconnected connectors */
  if (cardinality(Cl) == 0) then
    Cl.Q = 0;
    Cl.h = 1.e5;
    Cl.a = true;
  end if;
  if (cardinality(Cv) == 0) then
    Cv.Q = 0;
    Cv.h = 1.e5;
    Cv.b = true;
  end if;
  if (cardinality(Ce) == 0) then
    Ce.Q = 0;
    Ce.h = 1.e5;
    Ce.b = true;
  end if;
/* Wall temperature and HeatFlowRate*/
  Cth1.T = Tp1;
  Cth1.W = dW1;
  Cth2.T = Tp2;
  Cth2.W = dW2;
  Cth3.T = Tp3;
  Cth3.W = dW3;
/* Model boundaries */
  Cl.P = Pfond;
  Cv.P = P;
  Ce.P = P;
/* Cavity length */
  V = pi*R*R*L;
/* Liquid volume */
  if Vertical then
    theta = 1;
    Al = pi*R^2;
    Vl = Al*zl;
    Avl = Al;
    NbTubT = NbTub1;
  else
    theta = Modelica.Math.asin(max(-0.9999, min(0.9999, (R - zl)/R)));
    Al = (pi/2 - theta)*R^2 - R*(R - zl)*Modelica.Math.cos(theta);
    Vl = Al*L;
    Avl = 2*R*Modelica.Math.cos(theta)*L;
    NbTubT = NbTub1 + NbTub3;
  end if;
/* Heat exchange surface*/
  Surf_ext1 = pi*Dext*L1/Ns*NbTub1;
  Surf_ext2 = pi*Dext*L2/Ns*NbTub2;
  Surf_ext3 = pi*Dext*L3/Ns3*NbTub3;
  Surf_tot = Ns*Surf_ext1 + Ns*Surf_ext2 + Ns3*Surf_ext3;
/* Cavity volume */
  V = Vl + Vv;
/* Water leval */
  yLevel.signal = zl;
/* Liquid surface and vapor surface on contact with wall */
  Alp = if Vertical then 2*sqrt(pi/Al)*Vl + Al else (pi - 2*theta)*R*L + 2*Al;
  Avp = if Vertical then 2*sqrt(pi/Al)*Vv + Al else (pi + 2*theta)*R*L + 2*(pi*R^2 - Al);
/* Wall surface on contact with the outside */
  Ape = Alp + Avp;
/* Pressure at the bottom of the cavity */
  Pfond = P + prod.d*g*zl;
/* Liquid phase mass balance equation */
  BQl = -Cl.Q + Qcond - Qevap + (1 - proe.x)*Ce.Q;
  rhol*der(Vl) + Vl*(prol.ddph*der(P) + prol.ddhp*der(hl)) = BQl;
/* Vapor phase mass balance equation */
  BQv = Cv.Q + Qevap - Qcond + proe.x*Ce.Q;
  rhov*der(Vv) + Vv*(prov.ddph*der(P) + prov.ddhp*der(hv)) = BQv;
/* Liquid phase energy balance equation */
  BHl = -Cl.Q*(Cl.h - (hl - P/rhol)) + Qcond*(lsat.h - (hl - P/rhol)) - Qevap*(vsat.h - (hl - P/rhol)) + (1 - proe.x)*Ce.Q*((if (proe.x > 0) then lsat.h else Ce.h) - (hl - P/rhol)) - Wpl + Wvl + W1t;
  Vl*((P/rhol*prol.ddph - 1)*der(P) + (P/rhol*prol.ddhp + rhol)*der(hl)) = BHl;
/* Gas phase energy balance equation */
  BHv = Cv.Q*(Cv.h - (hv - P/rhov)) + Qevap*(vsat.h - (hv - P/rhov)) - Qcond*(lsat.h - (hv - P/rhov)) + proe.x*Ce.Q*((if (proe.x < 1) then vsat.h else Ce.h) - (hv - P/rhov)) - Wvl - Wpv + W2t + W3t;
  Vv*((P/rhov*prov.ddph - 1)*der(P) + (P/rhov*prov.ddhp + rhov)*der(hv)) = BHv;
  Cl.h_vol = hl;
  Ce.h_vol = hl;
  Cv.h_vol = hv;
/* Energy balance equation at the wall */
  Mp*cpp*der(Tp) = Wpl + Wpv - Wpa;
/* Heat exchange between liquid and gas phases */
  Wvl = Kvl*Avl*(Tv - Tl);
/* Heat exchange between the liquid phase and the wall */
  Wpl = Klp*Alp*(Tl - Tp);
/* Heat exchange between the gas phase and the wall */
  Wpv = Kvp*Avp*(Tv - Tp);
/* Thermal power losses to ambiant, for simplifid we use the wall surface on contact with the fluid (Ape)*/
  Wpa = Kpa*Ape*(Tp - Ta);
/* Condensation and evaporation mass flow rates */
  Qcond = if (xv < Xvo) then Ccond*rhov*Vv*(Xvo - xv) else 0;
  Qevap = if (xl > Xlo) then Cevap*rhol*Vl*(xl - Xlo) else 0;
/* Fluid thermodynamic properties */
  proe = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(P, Ce.h, 0);
//prol = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(P, hl, 0);
  prol = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph((P + Pfond)/2, hl, 0);
  provIn = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(P, Cv.h, 0);
  prov = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(P, hv, 0);
  prod = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Pfond, Cl.h, 0);
  (lsat, vsat) = ThermoSysPro.Properties.WaterSteam.IF97.Water_sat_P(P);
  Tl = prol.T;
  rhol = prol.d;
  xl = prol.x;
  Tv = prov.T;
  rhov = prov.d;
  xv = prov.x;
  mul = ThermoSysPro.Properties.WaterSteam.IF97.DynamicViscosity_rhoT(rhol, Tl);
  kl = noEvent(ThermoSysPro.Properties.WaterSteam.IF97.ThermalConductivity_rhoT(rhol, Tl, P, 0));
/* Heat transfer coefficient of fluid
                   And
     Power exchanged for each section
    ----------------------------------*/
/* Heat transfer coefficient of liquid*/
//SACADOURA
  DH = if step_square then 4*PasL^2/(pi*Dext) - Dext else ((2*PasL*PasT) - (pi*Dext^2*(Angle/120)))/(pi*Dext*(Angle/120));
  QS = Cl.Q/(DIc*Lc*(PasL - Dext)/PasL);
  Rel = noEvent(abs(QS*DH/mul));
  Prl = mul*prol.cp/kl;
  assert((PasL - Dext) > 0, "Error Data for TwoPhaseCavity model (PasL - Dext)<=0 ");
  for i in 1:Ns loop
    mult[i] = ThermoSysPro.Properties.WaterSteam.IF97.DynamicViscosity_rhoT(rhol, Tp1[i]);
    EE[i] = max((PasT/Dext - 1/2/((((PasL/Dext)^2 + (PasT/Dext/2)^2)^0.5/Dext) - 1)), 1);
/* Heat transfer coefficient of liquid*/
    if Cal_hconv then
// Kern corelation (SACADOURA)
      hliqu[i] = noEvent(if ((Rel > 1.e-6) and (Prl > 1.e-6)) then (COPl*0.36*kl/Dext*Rel^0.55*Prl^0.3333*(mul/mult[i])^0.14) else 10);
    else
      hliqu[i] = COPl*hliq;
    end if;
    if Cal_hconv then
/* Heat transfer coefficient of vapeur*/
      if Vertical then
// Frank P. & David P. Fundamentals of Heat Transfer  For (PasL/Dext)= 1.4
        hcond2[i] = COPv*noEvent(min(1.13*(max((g*lsat.rho*(lsat.rho - vsat.rho)*kl^3*(vsat.h - lsat.h))/(max(L2, 1)*mul*abs(lsat.T - Tp2[i] + 1e-6)), 2.225e15))^0.25, 20000));
      else
// Nusselt corelation
//******************
        hcond2[i] = COPv*noEvent(min(0.728*(max((g*lsat.rho*(lsat.rho - vsat.rho)*kl^3*(vsat.h - lsat.h))/(NbTubV*mul*Dext*abs(lsat.T - Tp2[i] + 1e-6)), 2.225e15))^0.25, 20000));
      end if;
    else
      hcond2[i] = COPv*hcond;
    end if;
/* Power exchanged for each section zone 1*/
    if (noEvent(abs(dW1[i]) < 0.1)) then
      dW1[i] = -h4*S4*(Tv - Tp1[i]);
    else
      dW1[i] = -hliqu[i]*Surf_ext1*((Tv + Tl)/2 - (Tp1[1] + Tp1[Ns])/2);
    end if;
/* Power exchanged for each section zone 2*/
    if (noEvent(abs(dW2[i]) < 0.1)) then
      dW2[i] = -h4*S4*(Tv - Tp2[i]);
    else
      dW2[i] = -hcond2[i]*Surf_ext2*(Tv - Tp2[i]);
    end if;
  end for;
  for i in 1:Ns3 loop
    if Cal_hconv then
/* Heat transfer coefficient of vapeur*/
      if Vertical then
// Frank P. & David P. Fundamentals of Heat Transfer  For vertical plate
        hcond3[i] = COPv*noEvent(min(1.13*(max((g*lsat.rho*(lsat.rho - vsat.rho)*kl^3*(vsat.h - lsat.h))/(max(L3, 1)*mul*abs(lsat.T - Tp3[i] + 1e-6)), 2.225e15))^0.25, 20000));
      else
// Nusselt corelation
//******************
        hcond3[i] = COPv*noEvent(min(0.728*(max((g*lsat.rho*(lsat.rho - vsat.rho)*kl^3*(vsat.h - lsat.h))/(NbTubV*mul*Dext*abs(lsat.T - Tp3[i] + 1e-6)), 2.225e15))^0.25, 20000));
      end if;
    else
      hcond3[i] = COPv*hcond;
    end if;
/* Power exchanged for each section  zone 3 + power exchanged for Deheating*/
    if (noEvent(abs(dW3[i]) < 0.1)) then
      dW3[i] = -h4*S4*(Tv - Tp3[i]);
    else
      dW3[i] = -hcond3[i]*Surf_ext3*(Tv - Tp3[i]) + W4t/Ns3;
    end if;
  end for;
  W1t = sum(dW1);
  W2t = sum(dW2);
  W3t = sum(dW3);
/* Total power exchanged for Deheating*/
  W4t = noEvent(if (Cv.h > vsat.h) then -Cv.Q*(Cv.h - vsat.h) else -0.0001);
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-250, -200}, {100, 100}}, grid = {2, 2}, initialScale = 0.1), graphics = {Text(extent = {{-142, 2}, {-124, -6}}, lineColor = {0, 0, 255}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, textString = "Pipe 3"), Text(extent = {{-164, 55}, {-88, 19}}, lineColor = {0, 0, 255}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, textString = "Horizontal_1pipe"), Rectangle(extent = {{-158, -6}, {-102, -10}}, lineColor = {0, 0, 255}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Line(points = {{-184, 16}, {-166, 16}}, color = {0, 0, 255}, arrow = {Arrow.Filled, Arrow.None}), Text(extent = {{-198, -6}, {-160, -24}}, lineColor = {0, 0, 255}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, textString = "in"), Line(points = {{-180, -8}, {-162, -8}}, color = {0, 0, 255}, arrow = {Arrow.None, Arrow.Filled}), Line(points = {{-102, -8}, {-96, -8}, {-96, 16}, {-160, 16}, {-170, 16}}, color = {0, 0, 255}, arrow = {Arrow.None, Arrow.Filled}), Rectangle(extent = {{-162, 28}, {-90, -44}}, lineColor = {0, 0, 255}, pattern = LinePattern.Dash), Text(extent = {{-182, -56}, {-86, -78}}, lineColor = {0, 0, 255}, textString = "Vertical Separate"), Rectangle(extent = {{-170, -100}, {-166, -152}}, lineColor = {0, 0, 255}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Line(points = {{-114, -76}, {-114, -94}}, color = {0, 0, 255}, arrow = {Arrow.None, Arrow.Filled}), Rectangle(extent = {{-116, -100}, {-112, -152}}, lineColor = {0, 0, 255}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Line(points = {{-168, -76}, {-168, -94}}, color = {0, 0, 255}, arrow = {Arrow.Filled, Arrow.None}), Rectangle(extent = {{-166, -176}, {-120, -180}}, lineColor = {0, 0, 255}, fillColor = {85, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-190, -128}, {-172, -136}}, lineColor = {0, 0, 255}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, textString = "Pipe 2"), Text(extent = {{-152, -180}, {-134, -188}}, lineColor = {0, 0, 255}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, textString = "Pipe 1"), Text(extent = {{-111, -122}, {-93, -130}}, lineColor = {0, 0, 255}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, textString = "Pipe 3"), Text(extent = {{-210, -164}, {-172, -182}}, lineColor = {0, 0, 255}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, textString = "in"), Line(points = {{-168, -150}, {-168, -160}, {-114, -160}, {-114, -150}}, color = {0, 0, 255}, pattern = LinePattern.Dash, arrow = {Arrow.Filled, Arrow.None}), Line(points = {{-183, -168}, {-105, -168}}, color = {0, 0, 255}, pattern = LinePattern.Dash), Rectangle(extent = {{-182, -96}, {-106, -192}}, lineColor = {0, 0, 255}, pattern = LinePattern.Dash), Line(points = {{-114, -78}, {-114, -72}, {-92, -72}, {-92, -178}, {-120, -178}}, color = {0, 0, 255}, pattern = LinePattern.Dash, arrow = {Arrow.Filled, Arrow.None}), Line(points = {{-188, -178}, {-170, -178}}, color = {0, 0, 255}, arrow = {Arrow.None, Arrow.Filled}), Text(extent = {{12, -54}, {54, -70}}, lineColor = {0, 0, 255}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, textString = "Vertical"), Rectangle(extent = {{4, -82}, {8, -134}}, lineColor = {0, 0, 255}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Line(points = {{6, -58}, {6, -76}}, color = {0, 0, 255}, arrow = {Arrow.None, Arrow.Filled}), Rectangle(extent = {{58, -82}, {62, -134}}, lineColor = {0, 0, 255}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Line(points = {{60, -60}, {60, -78}}, color = {0, 0, 255}, arrow = {Arrow.Filled, Arrow.None}), Rectangle(extent = {{10, -142}, {56, -146}}, lineColor = {0, 0, 255}, fillColor = {85, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-16, -104}, {2, -112}}, lineColor = {0, 0, 255}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, textString = "Pipe 2"), Text(extent = {{16, -162}, {42, -154}}, lineColor = {0, 0, 255}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, textString = "Pipe 1"), Text(extent = {{65, -112}, {83, -120}}, lineColor = {0, 0, 255}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, textString = "Pipe 3"), Text(extent = {{-20, -50}, {18, -68}}, lineColor = {0, 0, 255}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, textString = "in"), Line(points = {{6, -134}, {6, -144}, {60, -144}, {60, -134}}, color = {0, 0, 255}, arrow = {Arrow.None, Arrow.Filled}), Line(points = {{-7, -138}, {71, -138}}, color = {0, 0, 255}, pattern = LinePattern.Dash), Rectangle(extent = {{-8, -78}, {70, -152}}, lineColor = {0, 0, 255}, pattern = LinePattern.Dash), Rectangle(extent = {{2, -20}, {58, -24}}, lineColor = {0, 0, 255}, fillColor = {85, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{32, 34}, {50, 26}}, lineColor = {0, 0, 255}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, textString = "Pipe 2"), Text(extent = {{16, -26}, {34, -34}}, lineColor = {0, 0, 255}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, textString = "Pipe 1"), Text(extent = {{18, 10}, {36, 2}}, lineColor = {0, 0, 255}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, textString = "Pipe 3"), Text(extent = {{4, 60}, {56, 34}}, lineColor = {0, 0, 255}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, textString = "Horizontal"), Rectangle(extent = {{2, 2}, {58, -2}}, lineColor = {0, 0, 255}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Rectangle(extent = {{2, 26}, {58, 22}}, lineColor = {0, 0, 255}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Line(points = {{-24, 24}, {-6, 24}}, color = {0, 0, 255}, arrow = {Arrow.Filled, Arrow.None}), Line(points = {{-36, -22}, {-4, -22}}, color = {0, 0, 255}, arrow = {Arrow.None, Arrow.Filled}), Text(extent = {{-58, -10}, {-20, -28}}, lineColor = {0, 0, 255}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, textString = "in"), Line(points = {{60, -22}, {72, -22}, {72, 24}, {60, 24}, {58, 24}}, color = {0, 0, 255}, arrow = {Arrow.None, Arrow.Filled}), Line(points = {{-20, 0}, {-2, 0}}, color = {0, 0, 255}, arrow = {Arrow.None, Arrow.Filled}), Line(points = {{-20, -22}, {-20, -3}, {-20, -1}}, color = {0, 0, 255}, arrow = {Arrow.None, Arrow.Filled}), Line(points = {{58, 0}, {64, 0}, {64, 12}, {-10, 12}, {-10, 24}}, color = {0, 0, 255}, arrow = {Arrow.None, Arrow.Filled}), Rectangle(extent = {{-2, 36}, {76, -38}}, lineColor = {0, 0, 255}, pattern = LinePattern.Dash), Line(points = {{-2, -16}, {76, -16}}, color = {0, 0, 255}, pattern = LinePattern.Dash), Rectangle(extent = {{-160, 18}, {-142, 14}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{2, 26}, {20, 22}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-170, -100}, {-166, -116}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{58, -82}, {62, -98}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid), Text(extent = {{-234, 64}, {-164, 36}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, textString = "Pipe4=deheating pipes"), Text(extent = {{-158, 26}, {-140, 18}}, lineColor = {0, 0, 255}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, textString = "Pipe 4"), Text(extent = {{0, 34}, {18, 26}}, lineColor = {0, 0, 255}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, textString = "Pipe 4"), Text(extent = {{64, -86}, {82, -94}}, lineColor = {0, 0, 255}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, textString = "Pipe 4"), Text(extent = {{-190, -104}, {-172, -112}}, lineColor = {0, 0, 255}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, textString = "Pipe 4"), Text(extent = {{-132, -36}, {38, -50}}, lineColor = {0, 0, 255}, textString = "Connected here for one pipe only")}),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-250, -200}, {100, 100}}, grid = {2, 2}, initialScale = 0.1), graphics = {Ellipse(extent = {{-100, 50}, {100, -150}}, lineColor = {0, 0, 255}, fillColor = {170, 213, 255}, fillPattern = FillPattern.Solid), Ellipse(extent = {{-250, 50}, {-50, -150}}, lineColor = {0, 0, 255}, fillColor = {170, 213, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-160, 50}, {8, -150}}, lineColor = {255, 255, 0}, fillColor = {170, 213, 255}, fillPattern = FillPattern.Solid), Line(points = {{-250, -48}, {-160, -48}}, color = {255, 255, 0}), Line(points = {{-160, -48}, {100, -48}}, color = {255, 255, 0}, pattern = LinePattern.Dash), Line(points = {{-160, 50}, {-160, -150}}, color = {255, 255, 0}, thickness = 0.5), Line(points = {{-160, -98}, {88, -98}}, color = {0, 0, 255}, pattern = LinePattern.Dash), Line(points = {{-160, -112}, {78, -112}}, color = {0, 0, 255}, pattern = LinePattern.Dash), Line(points = {{-160, -126}, {66, -126}}, color = {0, 0, 255}, pattern = LinePattern.Dash), Line(points = {{-160, -106}, {82, -106}}, color = {0, 0, 255}, pattern = LinePattern.Dash), Line(points = {{-160, -118}, {72, -118}}, color = {0, 0, 255}, pattern = LinePattern.Dash), Line(points = {{-160, -132}, {56, -132}}, color = {0, 0, 255}, pattern = LinePattern.Dash), Line(points = {{-160, -150}, {8, -150}}, color = {0, 0, 255}, thickness = 0.5), Text(extent = {{-136, -12}, {34, -26}}, lineColor = {0, 0, 255}, textString = "Connected here for one pipe only")}),
    Window(x = 0.11, y = 0.06, width = 0.78, height = 0.88),
    Documentation(info = "
## Copyright © EDF 2002 - 2026  
## ThermoSysPro Version 4.2  
This component model is documented in Sect. 14.4 of the ThermoSysPro book.   

# Two phase cavity   
   
The two-phase cavity is a reservoir used to separate water from steam and store the separated phases.   
It can be a vertical or horizontal cylinder.  
The component is divided in the desuperheating and condensation zones, located in the upper part, and the subcooled zone, located in the lower part.   
The pipes inside the cavity are divided in three categories:  
- the pipes drowned in the liquid, labeled Pipes 1,  
- the pipes immersed in steam, labeled Pipes 2,  
- the U-tubes completely immersed in steam, labeled Pipes 3.  


The TwoPhaseCavity component represents the dynamics of the thermal hydraulic  
phenomena of the fluids inside the cavity.   
The following thermal exchanges are taken into account:  
- between the fluids and the cooling fluid flowing in the tube bundle,  
- between the fluid and the wall,  
- between the cavity and the ambient environment,  
- between the fluid phases (condensation and vaporization).  

Following assumptions are made:  
- pressure losses are not taken into account in the cavity,  
- the liquid and vapor phases are not necessarily in thermal equilibrium, but always in pressure equilibrium.  



## Modelica component model  

The equations mentioned below are implemented in the component *TwoPhaseCavity*, located in the *WaterSteam.Volumes* sub-library.   
This component has 7 connectors:  
- Cv: steam input,  
- Ce: water input,  
- Cl: water output,  
- Cth1: thermal port,  
- Cth2: thermal port,  
- Cth3: thermal port,  
- yLevel: water level output.  
   
![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.Volumes.TwoPhaseCavity.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.Volumes.TwoPhaseCavity.svg)  

## Nomenclature  

| Symbol| Description| Unit| Definition| Modelica name |  
| :-------------------------------------- | :----------------------------------------------------------------------------------------------------------- | :-------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----------- |  
| \\\\(A\\_{l}\\\\)| Cross-sectional area of the liquid phase in the cavity| \\\\(\\mathrm{m}^{2}\\\\)| For a vertical cavity: \\\\(\\pi \\cdot \\mathrm{R}^{2}\\\\). <br/> For a horizontal cavity: <br/>  \\\\(\\left\\(\\frac{\\pi}{2}-\\theta\\right\\) \\cdot R^{2}\\\\)| Al |  
| \\\\(A\\_{l \\mathrm{w}}\\\\)| Contact surface between the liquid phase and the cavity wall| \\\\(\\mathrm{m}^{2}\\\\)| For a vertical cavity: <br/> \\\\(2 \\cdot \\pi \\cdot R \\cdot z\\_{l}+A\\_{l}\\\\).<br/>  For a horizontal cavity: <br/> \\\\(\\(\\pi-2 \\cdot \\theta\\) \\cdot R \\cdot L+2 \\cdot A\\_{l}\\\\).| Alp |  
| \\\\(A\\_{\\mathrm{vl}}\\\\)| Heat exchange surface between the vapor phase and the liquid phase| \\\\(\\mathrm{m}^{2}\\\\)| For a vertical cavity:<br/>  \\\\(A\\_{\\mathrm{l}}\\\\).<br/>  For a horizontal cavity:<br/>  \\\\(2 . R \\cdot L . \\cos \\(\\theta\\)\\\\)| Avl |  
| \\\\(A\\_{\\mathrm{vw}}\\\\)| Contact surface between the vapor phase and the cavity wall| \\\\(\\mathrm{m}^{2}\\\\)| For a vertical cavity: <br/> \\\\(2 \\cdot \\pi \\cdot R \\cdot\\left\\(L-z\\_{l}\\right\\)+A\\_{l}\\\\).<br/>  For a horizontal cavity: <br/> \\\\(\\(\\pi+2 \\cdot \\theta\\) \\cdot R \\cdot L\\\\) \\\\(+2\\left\\(\\pi \\cdot R^{2}-A\\_{l}\\right\\)\\\\).| Avp |  
| \\\\(A\\_{\\mathrm{wa}}\\\\)| Internal cavity surface| \\\\(\\mathrm{m}^{2}\\\\)| \\\\(A\\_{\\mathrm{vw}}+A\\_{\\mathrm{lw}}\\\\)| Ape |  
| \\\\(c\\_{\\mathrm{p}, 1}\\\\)| Specific heat capacity of the liquid phase in the cavity| \\\\(\\mathrm{J} / \\mathrm{kg} / \\mathrm{K}\\\\)|| prol.cp |  
| \\\\(c\\_{\\mathrm{p}, \\mathrm{v}}\\\\)| Specific heat capacity of the vapor phase in the cavity| \\\\(\\mathrm{J} / \\mathrm{kg} / \\mathrm{K}\\\\)|| prov.cp |  
| \\\\(c\\_{\\mathrm{p}, \\mathrm{w}}\\\\)| Specific heat capacity of the cavity wall| \\\\(\\mathrm{J} / \\mathrm{kg} / \\mathrm{K}\\\\)|| cpp |  
| \\\\(C\\_{\\text{cond }}\\\\)| Condensation coefficient with inverse time| \\\\(\\mathrm{s}^{-1}\\\\)|| Ccond |  
| \\\\(C\\_{\\text{evap }}\\\\)| Evaporation coefficient with inverse time| \\\\(\\mathrm{s}^{-1}\\\\)|| Cevap |  
| \\\\(\\mathrm{COP}\\_{l}\\\\)| Corrective term for the heat exchange coefficient for Pipes 1 \\(desuperheating zone\\)| \\\\(-\\\\)|| COPl |  
| \\\\(\\mathrm{COP}\\_{\\mathrm{v}}\\\\)| Corrective term for the heat exchange coefficient for Pipes 2 and Pipes 3 \\(condensation and subcooled zones\\) | \\\\(-\\\\)|| COPv |  
| \\\\(D\\_{\\mathrm{e}}\\\\)| Pipe external diameter, for one pipe| \\\\(\\mathrm{m}\\\\)|| Dext |  
| \\\\(D\\_{\\mathrm{h}}\\\\)| Cross-sectional equivalent diameter| \\\\(\\mathrm{m}\\\\)| For a square step: <br/> \\\\(\\frac{4 . \\mathrm{S}\\_{\\mathrm{L}}^{2}}{\\pi \\cdot D\\_{\\mathrm{e}}}-D\\_{\\mathrm{e}}\\\\).<br/>  For a triangular step: <br/> \\\\(\\frac{2 \\cdot \\mathrm{S}\\_{\\mathrm{L}} \\cdot \\mathrm{S}\\_{\\mathrm{T}}}{\\pi \\cdot D\\_{\\mathrm{e}} \\cdot \\frac{\\alpha}{120}}-D\\_{\\mathrm{e}}\\\\) | DH |  
| \\\\(D\\_{\\mathrm{s}}\\\\)| Shell internal diameter| \\\\(\\mathrm{m}\\\\)|| DIc |  
| \\\\(g\\\\)| Acceleration due to gravity| \\\\(\\mathrm{m} / \\mathrm{s}^{2}\\\\)|| g |  
| \\\\(h\\\\)| Specific enthalpy of the fluid in the cavity \\(liquid or vapor\\)| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| - |  
| \\\\(h\\_{\\text{conv}j, i}\\\\)| Convective coefficient of heat transfer by condensation between the vapor and the tube bundle for Pipes *j*| \\\\(\\mathrm{W} / \\mathrm{m}^{2} / \\mathrm{K}\\\\)|| hcond2 |  
| \\\\(h\\_{\\text{drain,i }}\\\\)| Specific enthalpy at the drain inlet| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| hcond3 | Ce.h | |  
| \\\\(h\\_{\\mathrm{fg}}\\\\)| Latent energy at the cavity pressure| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| vsat.h - lsat.h |  
| \\\\(h\\_{l}\\\\)| Specific enthalpy of the liquid phase in the cavity| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| hl |  
| \\\\(h\\_{l, \\text{ drain, }, \\mathrm{i}}\\\\)| Specific enthalpy of the liquid at the drain inlet| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| Ce.h |  
| \\\\(h\\_{l,0}\\\\)| Specific enthalpy of the liquid at the outlet \\(outgoing condensate\\)| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| Cl.h |  
| \\\\(h\\_{l}^{\\text{sat }}\\\\)| Saturation enthalpy of the liquid in the cavity| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| lsat.h |  
| \\\\(h\\_{\\mathrm{v}}\\\\)| Specific enthalpy of the vapor phase in the cavity| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| hv |  
| \\\\(h\\_{\\mathrm{v}, \\text{ drain, } i}\\\\)| Specific enthalpy of the vapor at the drain inlet| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| Ce.h |  
| \\\\(h\\_{\\mathrm{v}, \\mathrm{i}}\\\\)| Specific enthalpy of the steam at the inlet, coming from the steam turbine| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| Cv.h |  
| \\\\(h\\_{\\mathrm{v}}^{\\mathrm{sat}}\\\\)| Saturation enthalpy of the vapor in the cavity| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| vsat.h |  
| \\\\(K\\_{\\mathrm{corr}}\\\\)| Corrective term for the heat exchange coefficient between the liquid and the steam| \\\\(-\\\\)|| - |  
| \\\\(K\\_{l \\mathrm{w}}\\\\)| Convective heat exchange coefficient between the liquid and the wall| \\\\(\\mathrm{W} / \\mathrm{m}^{2} / \\mathrm{K}\\\\)|| Klp |  
| \\\\(K\\_{\\mathrm{vl}}\\\\)| Convective heat exchange coefficient between the liquid and the vapor in the cavity| \\\\(\\mathrm{W} / \\mathrm{m}^{2} / \\mathrm{K}\\\\)|| Kvl |  
| \\\\(K\\_{\\mathrm{vw}}\\\\)| Convective heat exchange coefficient between the vapor and the wall| \\\\(\\mathrm{W} / \\mathrm{m}^{2} / \\mathrm{K}\\\\)|| Kvp |  
| \\\\(K\\_{\\mathrm{wa}}\\\\)| Convective heat exchange coefficient between the wall and the ambient| \\\\(\\mathrm{W} / \\mathrm{m}^{2} / \\mathrm{K}\\\\)|| Kpa |  
| \\\\(L\\\\)| Cavity length| \\\\(\\mathrm{m}\\\\)|| L |  
| \\\\(L\\_{\\mathrm{t}}\\\\)| Total pipe length| \\\\(\\mathrm{m}\\\\)|| - |  
| \\\\(L\\_{j}\\\\)| Total length of Pipes 1| \\\\(\\mathrm{m}\\\\)|| L1 |  
| \\\\(L\\_{j}\\\\)| Total length of Pipes 2| \\\\(\\mathrm{m}\\\\)| \\\\(L\\_{2}=L\\_{l}\\\\)| L2 |  
| \\\\(L\\_{j}\\\\)| Total length of Pipes 3| \\\\(\\mathrm{m}\\\\)|| L3 |  
| \\\\(L\\_{\\mathrm{c}}\\\\)| Distance between two plates in the shell \\(support plate spacing in the cooling zone\\)| \\\\(\\mathrm{m}\\\\)|| Lc |  
| \\\\(N\\_{\\mathrm{t}}\\\\)| Number of pipes in a vertical row \\\\(\\(\\text{ tube bank }\\)\\\\)| \\\\(-\\\\)|| NbTubV |  
| \\\\(N\\_{l}\\\\)| Number of Pipes 1| \\\\(-\\\\)|| NbTub1 |  
| \\\\(N\\_{2}\\\\)| Number of Pipes 2| \\\\(-\\\\)|| NbTub2 |  
| \\\\(N\\_{3}\\\\)| Number of Pipes 3||| NbTub3 |  
| \\\\(N\\_{\\mathrm{s}}\\\\)| Number of segments for Pipes 1 and Pipes 2| \\\\(-\\\\)|| Ns |  
| \\\\(N\\_{\\mathrm{s}\\_{3}}\\\\)| Number of segments for Pipes 3| \\\\(-\\\\)| \\\\(2 \\cdot N\\_{s}\\\\)| Ns3 |  
| \\\\(M\\_{\\mathrm{w}}\\\\)| Mass of the wall cavity| \\\\(\\mathrm{kg}\\\\)|| Mp |  
| \\\\(\\dot{m}\\_{l, \\mathrm{o}}\\\\)| Mass flow rate of the outgoing condensate| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Cl.Q |  
| \\\\(\\dot{m}\\_{\\mathrm{v}}\\\\)| Mass flow rate of the incoming vapor| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Cv.Q |  
| \\\\(\\dot{m}\\_{\\text{drain, } \\mathrm{i}}\\\\) | Mass flow rate at the drain inlet| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Ce.Q |  
| \\\\(m\\_{\\text{cond }}\\\\)| Condensation mass flow rate inside the cavity| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Qcond |  
| \\\\(\\dot{m}\\_{\\text{evap }}\\\\)| Evaporation mass flow rate inside the cavity| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Qevap |  
| \\\\(P\\\\)| Cavity pressure| \\\\(\\mathrm{Pa}\\\\)|| P |  
| \\\\(P\\_{\\mathrm{b}}\\\\)| Fluid pressure at the bottom of the cavity| \\\\(\\mathrm{Pa}\\\\)| \\\\(P+\\rho\\_{l} \\cdot g \\cdot z\\_{l}\\\\)| Pfond |  
| \\\\(P r\\_{l}\\\\)| Prandtl number of the liquid phase| \\\\(-\\\\)| \\\\(\\frac{\\mu\\_{l} \\cdot c\\_{\\mathrm{pl}}}{\\lambda\\_{l}}\\\\)| Prl |  
| \\\\(P r\\_{\\mathrm{v}}\\\\)| Prandtl number of the vapor phase| \\\\(-\\\\)| \\\\(\\frac{\\mu\\_{\\mathrm{v}} \\cdot c\\_{\\mathrm{pv}}}{\\lambda\\_{\\mathrm{v}}}\\\\)| - |  
| \\\\(Q\\_{\\mathrm{s}}\\\\)| Surface mass flow rate in the shell| \\\\(\\mathrm{kg} / \\mathrm{s} / \\mathrm{m}^{2}\\\\) | \\\\(\\frac{\\dot{m}\\_{l, \\mathrm{o}}}{D\\_{\\mathrm{s}} \\cdot L\\_{\\mathrm{c}} \\cdot \\left\\( \\frac{S\\_{\\mathrm{L}}-D\\_{\\mathrm{e}}}{S\\_{\\mathrm{L}}} \\right\\)}\\\\)| QS |  
| \\\\(R\\\\)| Radius of the cavity cross-sectional area| \\\\(\\mathrm{m}\\\\)|| R |  
| \\\\(R e\\_{l}\\\\)| Reynolds number of the condensate flowing between the drowned tubes| \\\\(-\\\\)| \\\\(\\frac{Q\\_{s} \\cdot D\\_{h}}{\\mu\\_{l}}\\\\)| Rel |  
| \\\\(R e\\_{l, w}\\\\)| Reynolds number of the condensate flowing against cavity wall| \\\\(-\\\\)|| - |  
| \\\\(R e\\_{v, 1}\\\\)| Reynolds number of the vapor flowing against the free surface of the condensate| \\\\(-\\\\)|| - |  
| \\\\(R e\\_{v, w}\\\\)| Reynolds number of the vapor flowing against the cavity wall| \\\\(-\\\\)|| - |  
| \\\\(S\\_{\\mathrm{L}}\\\\)| Longitudinal step| \\\\(\\mathrm{m}\\\\)|| PaSL |  
| \\\\(S\\_{\\mathrm{T}}\\\\)| Transverse step| \\\\(\\mathrm{m}\\\\)|| PasT |  
| \\\\(T\\_{\\mathrm{a}}\\\\)| Ambient temperature| \\\\(\\mathrm{K}\\\\)|| Ta |  
| \\\\(T\\_{l}\\\\)| Liquid temperature in the cavity| \\\\(\\mathrm{K}\\\\)|| Tl |  
| \\\\(T\\_{\\mathrm{w}}\\\\)| Wall temperature of the cavity| \\\\(\\mathrm{K}\\\\)|| Tp |  
| \\\\(T\\_{\\mathrm{w}1, i}\\\\)| Wall temperature for Pipes 1| \\\\(\\mathrm{K}\\\\)|| Tp1 |  
| \\\\(T\\_{\\mathrm{w}2, i}\\\\)| Wall temperature for Pipes 2| \\\\(\\mathrm{K}\\\\)|| Tp2 |  
| \\\\(T\\_{\\mathrm{w}3, i}\\\\)| Wall temperature for Pipes 3| \\\\(\\mathrm{K}\\\\)|| Tp3 |  
| \\\\(T\\_{\\text{sat }}\\\\)| Saturation temperature in the cavity| \\\\(\\mathrm{K}\\\\)|| lsat.T, vsat.T |  
| \\\\(T\\_{\\mathrm{v}}\\\\)| Vapor temperature in the cavity| \\\\(\\mathrm{K}\\\\)|| Tv |  
| \\\\(u\\\\)| Fluid specific internal energy| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)| \\\\(h-\\frac{P}{\\rho}\\\\)| - |  
| \\\\(V\\\\)| Volume of the cavity| \\\\(\\mathrm{m}^{3}\\\\)| \\\\(V\\_{l}+V\\_{v}\\\\)| V |  
| \\\\(V\\_{l}\\\\)| Volume of the liquid phase in the cavity| \\\\(\\mathrm{m}^{3}\\\\)| \\\\(V\\_{l}=A\\_{l} \\cdot z\\_{l}\\\\)| Vl |  
| \\\\(V\\_{\\mathrm{v}}\\\\)| Volume of the vapor phase in the cavity| \\\\(\\mathrm{m}^{3}\\\\)|| Vv |  
| \\\\(W\\_{1 \\mathrm{t}}\\\\)| Total power exchanged from liquid or vapor to Pipes 1| \\\\(\\mathrm{W}\\\\)|| W1t |  
| \\\\(W\\_{2 \\mathrm{t}}\\\\)| Total power exchanged from liquid or vapor to Pipes 2| \\\\(\\mathrm{W}\\\\)|| W2t |  
| \\\\(W\\_{3 \\mathrm{t}}\\\\)| Total power exchanged from liquid or vapor to Pipes 3| \\\\(\\mathrm{W}\\\\)|| W3t |  
| \\\\(W\\_{4 \\mathrm{t}}\\\\)| Total power exchanged for steam desuperheating| \\\\(\\mathrm{W}\\\\)|| W4t |  
| \\\\(W\\_{\\mathrm{vl}}\\\\)| Power exchanged from the vapor to the liquid| \\\\(\\mathrm{W}\\\\)|| Wvl |  
| \\\\(W\\_{\\mathrm{lw}}\\\\)| Power exchanged from the liquid to the cavity wall| \\\\(\\mathrm{W}\\\\)|| Wpl |  
| \\\\(W\\_{\\mathrm{vw}}\\\\)| Power exchanged from the vapor to the cavity wall| \\\\(\\mathrm{W}\\\\)|| Wpv |  
| \\\\(W\\_{\\mathrm{aw}}\\\\)| Power exchanged from the ambient environment to the cavity wall| \\\\(\\mathrm{W}\\\\)|| Wpa |  
| \\\\(x\\_{\\mathrm{v}}\\\\)| Vapor mass fraction in the vapor phase| \\\\(-\\\\)|| xl |  
| \\\\(X\\_{\\mathrm{vo}}\\\\)| Vapor mass fraction in the vapor phase from which the liquid starts to condensate| \\\\(-\\\\)|| Xvo |  
| \\\\(x\\_{l}\\\\)| Vapor mass fraction in the liquid phase| \\\\(-\\\\)|| xv |  
| \\\\(X\\_{\\mathrm{lo}}\\\\)| Vapor mass fraction in the liquid phase from which the liquid starts to evaporate| \\\\(-\\\\)|| Xlo |  
| \\\\(x\\_{\\mathrm{mv}}\\\\)| Vapor mass fraction at the inlet of the drain| \\\\(-\\\\)|| proe.x |  
| \\\\(z\\_{l}\\\\)| Liquid level in the cavity| \\\\(\\mathrm{m}\\\\)| \\\\(V\\_{l} / A\\_{l}\\\\)| zl |  
| \\\\(\\alpha\\\\)| Average bend angle \\(pipes triangular step\\)| \\\\(\\circ\\\\)|| Angle |  
| \\\\(\\lambda\\_{l}\\\\)| Thermal conductivity of the liquid| \\\\(\\mathrm{W} / \\mathrm{m} / \\mathrm{K}\\\\)|| kl |  
| \\\\(\\lambda\\_{\\mathrm{v}}\\\\)| Thermal conductivity of the vapor| \\\\(\\mathrm{W} / \\mathrm{m} / \\mathrm{K}\\\\)|| - |  
| \\\\(\\Delta S\\_{\\text{ext }1}\\\\)| Heat exchange surface for each segment of Pipes 1| \\\\(\\mathrm{m}^{2}\\\\)| If \\\\(j=1,2\\\\): <br/> \\\\( \\pi \\cdot D\\_{\\mathrm{e}} \\cdot L\\_{j} \\cdot N\\_{j} / N\\_{\\mathrm{s}}\\\\). <br/>  If \\\\(j=3\\\\): \\\\( \\pi \\cdot D\\_{\\mathrm{e}} \\cdot L\\_{j} \\cdot N\\_{j} / N\\_{\\mathrm{s}_3}\\\\). | Surf_ext1 |  
| \\\\(\\Delta S\\_{\\text{ext }2}\\\\)| Heat exchange surface for each segment of Pipes 2| \\\\(\\mathrm{m}^{2}\\\\)| If \\\\(j=1,2\\\\): <br/> \\\\( \\pi \\cdot D\\_{\\mathrm{e}} \\cdot L\\_{j} \\cdot N\\_{j} / N\\_{\\mathrm{s}}\\\\). <br/>  If \\\\(j=3\\\\): \\\\( \\pi \\cdot D\\_{\\mathrm{e}} \\cdot L\\_{j} \\cdot N\\_{j} / N\\_{\\mathrm{s}_3}\\\\). | Surf_ext2 |  
| \\\\(\\Delta S\\_{\\text{ext }3}\\\\)| Heat exchange surface for each segment of Pipes 3| \\\\(\\mathrm{m}^{2}\\\\)| If \\\\(j=1,2\\\\): <br/> \\\\( \\pi \\cdot D\\_{\\mathrm{e}} \\cdot L\\_{j} \\cdot N\\_{j} / N\\_{\\mathrm{s}}\\\\). <br/>  If \\\\(j=3\\\\): \\\\( \\pi \\cdot D\\_{\\mathrm{e}} \\cdot L\\_{j} \\cdot N\\_{j} / N\\_{\\mathrm{s}_3}\\\\). | Surf_ext3 |  
| \\\\(\\rho\\_{l}\\\\)| Density of the liquid in the cavity| \\\\(\\mathrm{kg} / \\mathrm{m}^{3}\\\\)|| rhol |  
| \\\\(\\rho\\_{\\mathrm{v}}\\\\)| Density of the vapor in the cavity| \\\\(\\mathrm{kg} / \\mathrm{m}^{3}\\\\)|| rhov |  
| \\\\(\\mu\\_{l}\\\\)| Dynamic viscosity of the liquid in the cavity| \\\\(\\mathrm{kg} /\\(\\mathrm{m} \\mathrm{s}\\)\\\\)|| mul |  
| \\\\(\\mu\\_{\\mathrm{IT}}\\\\)| Dynamic viscosity of the liquid at the wall temperature| \\\\(\\mathrm{kg} /\\(\\mathrm{m} \\mathrm{s}\\)\\\\)|| mult |  
| \\\\(\\mu\\_{\\mathrm{v}}\\\\)| Dynamic viscosity of the vapor in the cavity| \\\\(\\mathrm{kg} /\\(\\mathrm{m} \\mathrm{s}\\)\\\\)|| - |  
| \\\\(\\theta\\\\)| Chord angle of the liquid in the horizontal cavity,| \\\\(\\mathrm{rad}\\\\)| \\\\(\\arcsin \\left\\(\\frac{R-z\\_{l}}{R}\\right\\)\\\\)| theta |  


## Governing equations  

### Dynamic mass balance equation for the liquid phase  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\\\) and \\\\(0<V\\_{l}<V\\\\)  

- Mathematical formulation:   
   
$$   \\rho_{1} \\frac{\\mathrm{d} V_{1}}{\\mathrm{d} t}+V_{1} \\cdot\\left[\\left(\\frac{\\partial \\rho_{1}}{\\partial P}\\right)_{h} \\cdot \\frac{\\mathrm{d} P}{\\mathrm{d} t}+\\left(\\frac{\\partial \\rho_{1}}{\\partial h}\\right)_{P} \\cdot \\frac{\\mathrm{d} h_{1}}{\\mathrm{d} t}\\right] =-\\dot{m}_{1, \\mathrm{o}}+\\left(1-x_{\\mathrm{mv}}\\right) \\cdot \\dot{m}_{\\mathrm{drain}, \\mathrm{i}} \\\\    + \\dot{m}_{\\mathrm{cond}} - \\dot{m}_{\\mathrm{evap}}$$  

- Comments:   
   



### Dynamic mass balance equation for the steam phase  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\\\) and \\\\(0<V\\_{\\mathrm{v}}<V\\\\)  

- Mathematical formulation:   
   
 $$\\rho\\_{\\mathrm{v}} \\cdot \\frac{\\mathrm{d} V\\_{\\mathrm{v}}}{\\mathrm{d} t}+V\\_{\\mathrm{v}} \\cdot\\left[\\left\\(\\frac{\\partial \\rho\\_{\\mathrm{v}}}{\\partial P}\\right\\)\\_{h} \\cdot \\frac{\\mathrm{d} P}{\\mathrm{d} t}+\\left\\(\\frac{\\partial \\rho\\_{\\mathrm{v}}}{\\partial h}\\right\\)\\_{P} \\cdot \\frac{\\mathrm{d} h\\_{\\mathrm{v}}}{\\mathrm{d} t}\\right]=\\dot{m}\\_{\\mathrm{v}}+x\\_{\\mathrm{mv}} \\cdot \\dot{m}\\_{\\mathrm{drain}, \\mathrm{i}}+\\dot{m}\\_{\\mathrm{evap}}-\\dot{m}\\_{\\mathrm{cond}}$$   

- Comments:   
   
### Dynamic energy balance equation for the liquid phase  

- Validity domain:   
   
\\\\(\\forall \\dot{m}\\\\) and \\\\(0<V\\_{l}<V\\\\)  

- Mathematical formulation:  

$$   V_{l}  \\cdot\\left[\\left(\\frac{P}{\\rho_{l}} \\cdot\\left(\\frac{\\partial \\rho_{l}}{\\partial P}\\right)_{h}-1\\right) \\cdot \\frac{\\mathrm{d} P}{\\mathrm{d} t} +\\left(\\frac{P}{\\rho_{l}} \\cdot\\left(\\frac{\\partial \\rho_{l}}{\\partial h_{l}}\\right)_{P}+\\rho_{l}\\right) \\cdot \\frac{\\mathrm{d} h_{l}}{\\mathrm{d} t}\\right] \\\\    =-\\dot{m}_{1, \\mathrm{o}} \\cdot\\left(h_{1, \\mathrm{o}}-\\left(h_{l}-\\frac{P}{\\rho_{l}}\\right)\\right)+\\dot{m}_{\\mathrm{cond}} \\cdot\\left(h_{l}^{\\mathrm{sat}}-\\left(h_{l}-\\frac{P}{\\rho_{l}}\\right)\\right) \\\\    \\quad -\\dot{m}_{\\mathrm{evap}} \\cdot\\left(h_{\\mathrm{v}}^{\\mathrm{sat}} -\\left(h_{l}-\\frac{P}{\\rho_{l}}\\right)\\right) \\\\    \\quad +\\left(1-x_{\\mathrm{mv}}\\right) \\cdot \\dot{m}_{\\mathrm{drain}, \\mathrm{i}} \\cdot\\left(h_{\\mathrm{l}, \\mathrm{drain}, \\mathrm{i}}-\\left(h_{l}-\\frac{P}{\\rho_{l}}\\right)\\right)+W_{\\mathrm{vl}}-W_{\\mathrm{lw}}-W_{1 \\mathrm{t}}$$  

- Comments:  

The value of \\\\(h\\_{l, \\text { drain }, i}\\\\) is given by:  
$$   h_{1, \\text{ drain }, \\mathrm{i}}=\\left\\{\\begin{array}{ll}   h_{\\text{drain, } i}  \\text{ for } x_{\\mathrm{mv}}=0 \\\\   h_{1}^{\\mathrm{sat}}  \\text{ for } x_{\\mathrm{mv}}>0   \\end{array}\\right.$$  

### Dynamic energy balance equation for the vapor phase  

- Validity domain:  

\\\\(\\forall \\dot{m}\\\\) and \\\\(0<V\\_{\\mathrm{v}}<V\\\\)  

- Mathematical formulation:   

$$   V_{\\mathrm{v}} \\cdot\\left[\\left(\\frac{P}{\\rho_{\\mathrm{v}}} \\cdot\\left(\\frac{\\partial \\rho_{\\mathrm{v}}}{\\partial P}\\right)_{\\mathrm{h}}-1\\right) \\cdot \\frac{\\mathrm{d} P}{\\mathrm{d} t}+\\left(\\frac{P}{\\rho_{\\mathrm{v}}} \\cdot\\left(\\frac{\\partial \\rho_{\\mathrm{v}}}{\\partial h_{\\mathrm{v}}}\\right)_{P} +\\rho_{\\mathrm{v}}\\right) \\cdot \\frac{\\mathrm{d} h_{\\mathrm{v}}}{\\mathrm{d} t}\\right]\\\\   =\\dot{m}_{\\mathrm{v}} \\cdot\\left(h_{\\mathrm{v}, \\mathrm{i}}-\\left(h_{\\mathrm{v}}-\\frac{P}{\\rho_{\\mathrm{v}}}\\right)\\right)-\\dot{m}_{\\mathrm{cond}} \\cdot\\left(h_{1}^{\\mathrm{sat}}-\\left(h_{\\mathrm{v}}-\\frac{P}{\\rho_{\\mathrm{v}}}\\right)\\right)\\\\   \\quad+\\dot{m}_{\\mathrm{evap}} \\cdot\\left(h_{\\mathrm{v}}^{\\mathrm{sat}}-\\left(h_{\\mathrm{v}}-\\frac{P}{\\rho_{\\mathrm{v}}}\\right)\\right)\\\\   \\quad+x_{\\mathrm{mv}} \\cdot \\dot{m}_{\\mathrm{drain}, \\mathrm{i}} \\cdot\\left(h_{\\mathrm{v}, \\mathrm{drain}, \\mathrm{i}}-\\left(h_{\\mathrm{v}}-\\frac{P}{\\rho_{\\mathrm{v}}}\\right)\\right) \\\\   \\quad-W_{\\mathrm{vl}}-W_{\\mathrm{vw}}-W_{2 \\mathrm{t}}-W_{3 \\mathrm{t}}-W_{4 \\mathrm{t}}$$  

- Comments:  

The value of \\\\(h\\_{\\mathrm{v}, \\text { drain, } i}\\\\) is given by:  
$$   h_{\\mathrm{v}, \\mathrm{drain}, \\mathrm{i}}=\\left\\{\\begin{array}{ll}h_{\\mathrm{drain}, \\mathrm{i}}  \\text{ for } x_{\\mathrm{mv}}=1 \\\\ h_{\\mathrm{v}}^{\\mathrm{sat}}  \\text{ for } x_{\\mathrm{mv}}<1\\end{array}\\right.$$  

### Energy accumulation in the wall  


- Validity domain:   
   
 \\\\(T\\_{\\mathrm{w}}<\\\\) melting temperature of the tubes metal  

- Mathematical formulation:   
   
 $$M\\_{\\mathrm{w}} \\cdot c\\_{\\mathrm{p}, \\mathrm{w}} \\cdot \\frac{\\mathrm{d} T\\_{\\mathrm{w}}}{\\mathrm{d} t}=W\\_{\\mathrm{lw}}+W\\_{\\mathrm{vw}}+W\\_{\\mathrm{aw}}$$  


### Power exchanged from the liquid to Pipes 1 \\(subcooled\\)  


    
    

- Validity domain:   
   
 \\\\(\\forall T\\_{l}\\\\) and \\\\(\\forall T\\_{\\mathrm{w} 1, \\mathrm{i}}\\\\)  

- Mathematical formulation:   
   
 $$W\\_{l \\mathrm{t}}=\\Delta S\\_{\\mathrm{ext} 1} \\cdot \\sum\\_{i=1}^{N\\_{\\mathrm{s}}} h\\_{\\mathrm{conv} 1, i} \\cdot\\left\\(T\\_{l}-T\\_{\\mathrm{w} 1, i}\\right\\)$$  

- Comments:   
   
 The power is exchanged by convection from the liquid to the pipes  


### Power exchanged from the vapor to Pipes 2  


    
    

- Validity domain:   
   
 \\\\(\\forall T\\_{\\mathrm{v}}\\\\) and \\\\(\\forall T\\_{\\mathrm{w} 2 \\mathrm{i}}\\\\)  

- Mathematical formulation:   
   
 $$W\\_{2 \\mathrm{t}}=\\Delta S\\_{\\mathrm{ext} 2} \\cdot \\sum\\_{i=1}^{N\\_{\\mathrm{s}}} h\\_{\\mathrm{cond} 2, i} \\cdot\\left\\(T\\_{\\mathrm{v}}-T\\_{\\mathrm{w} 2, i}\\right\\)$$  

- Comments:   
   
 The power is exchanged by convection from the vapor to the pipes  


### Power exchanged from the vapor to Pipes 3  

- Validity domain:   
   
 \\\\(\\forall T\\_{\\mathrm{V}}\\\\) and \\\\(\\forall T\\_{\\mathrm{W} 3 \\mathrm{i}}\\\\)  

- Mathematical formulation:   
   
 $$W\\_{3 \\mathrm{t}}=\\Delta S\\_{\\mathrm{ext} 3} \\cdot \\sum\\_{i=1}^{N\\_{\\mathrm{s}}} h\\_{\\mathrm{cond} 3, i} \\cdot\\left\\(T\\_{\\mathrm{v}}-T\\_{\\mathrm{w} 3, i}\\right\\)$$   

- Comments:   
   
 The power is exchanged by convection from the vapor to the pipes  


### Power exchanged for desuperheating of the vapor  

- Validity domain:  

\\\\(\\forall \\dot{m}\\_{\\mathrm{v}}\\\\)  

- Mathematical formulation:  

$$   W_{4 \\mathrm{t}}=\\left\\{\\begin{array}{ll}\\dot{m}_{\\mathrm{v}} \\cdot\\left(h_{\\mathrm{v}, \\mathrm{i}}-h_{\\mathrm{v}}^{\\text{sat }}\\right) \\text{for } h_{\\mathrm{v}, \\mathrm{i}}>h_{\\mathrm{v}}^{\\text{sat }} \\\\   0  \\text{for } h_{\\mathrm{v}, \\mathrm{i}}<h_{\\mathrm{v}}^{\\text{sat }} \\end{array}\\right.$$  

- Comments:  

The power is exchanged from the vapor to the pipes  

### Power exchanged from the vapor to the liquid  


    
    

- Validity domain:   
   
 \\\\(\\forall T\\_{\\mathrm{v}}\\\\) and \\\\(\\forall T\\_{l}\\\\)  

- Mathematical formulation:   
   
 $$W\\_{\\mathrm{vl}}=K\\_{\\mathrm{vl}} \\cdot A\\_{\\mathrm{p}} \\cdot\\left\\(T\\_{\\mathrm{v}}-T\\_{l}\\right\\)$$  

- Comments:   
   
 The power is exchanged by convection from the vapor to the liquid at the interface between the two phases.   


### Power exchanged from the liquid to the cavity wall  


    
    

- Validity domain:   
   
 \\\\(\\forall T\\_{l}\\\\) and \\\\(\\forall T\\_{\\mathrm{w}}\\\\)  

- Mathematical formulation:   
   
 $$W\\_{\\mathrm{lw}}=K\\_{\\mathrm{lw}} \\cdot A\\_{l} \\cdot\\left\\(T\\_{l}-T\\_{\\mathrm{w}}\\right\\)$$  

- Comments:   
   
 The power is exchanged by convection from the liquid to the cavity wall.  


### Power exchanged from the vapor to the cavity wall  


    
    

- Validity domain:   
   
 \\\\(\\forall T\\_{\\mathrm{v}}\\\\) and \\\\(\\forall T\\_{\\mathrm{w}}\\\\)  

- Mathematical formulation:   
   
 $$W\\_{\\mathrm{vw}}=K\\_{\\mathrm{vw}} \\cdot A\\_{\\mathrm{v}} \\cdot\\left\\(T\\_{\\mathrm{v}}-T\\_{\\mathrm{w}}\\right\\)$$  

- Comments:   
   
 The power is exchanged by convection from the vapor to the cavity wall.  


### Power exchanged from the ambient to the cavity wall  


    
    

- Validity domain:   
   
 \\\\(\\forall T\\_{\\mathrm{a}}\\\\) and \\\\(\\forall T\\_{\\mathrm{w}}\\\\)  

- Mathematical formulation:   
   
 $$W\\_{\\mathrm{aw}}=K\\_{\\mathrm{aw}} \\cdot A\\_{\\mathrm{e}} \\cdot\\left\\(T\\_{\\mathrm{a}}-T\\_{\\mathrm{w}}\\right\\)$$  

- Comments:   
   
 The power is exchanged by convection from the ambient to the cavity wall.  


### Condensation mass flow rate  


    
    

- Validity domain:   
   
 \\\\(\\forall x\\_{\\mathrm{v}}\\\\) close to \\\\(X\\_{\\mathrm{vo}}\\\\)  

- Mathematical formulation:   
   
 $$\\dot{m}\\_{\\text {cond }}=\\max \\left\\(C\\_{\\text {cond }} \\cdot \\rho\\_{\\mathrm{v}} \\cdot V\\_{\\mathrm{v}} \\cdot\\left\\(X\\_{\\mathrm{vo}}-x\\_{\\mathrm{v}}\\right\\), 0\\right\\)$$   

- Comments:   
   



### Evaporation mass flow rate  


    
    

- Validity domain:   
   
 \\\\(\\forall x\\_{l}\\\\) close to \\\\(X\\_{\\mathrm{lo}}\\\\)  

- Mathematical formulation:   
   
 $$\\dot{m}\\_{\\mathrm{evap}}=\\max \\left\\(C\\_{\\text {evap }} \\cdot \\rho\\_{l} \\cdot V\\_{l} \\cdot\\left\\(x\\_{l}-X\\_{\\mathrm{lo}}\\right\\), 0\\right\\)$$  

- Comments:   
   



### Convective heat transfer coefficient in zone 1 corresponding to the drowned tubes  


    
    

- Validity domain:   
   
 \\\\(100<\\mathrm{Re}\\_{l}<10^{6}\\\\)  

- Mathematical formulation:   
   
 $$h\\_{\\text {conv1 }}=\\frac{\\lambda\\_{l}}{D\\_{\\mathrm{e}}} \\cdot 0.36 \\cdot \\mathrm{COP}\\_{l} \\cdot \\operatorname{Re}\\_{l}^{0.55} \\cdot \\mathrm{Pr}\\_{l}^{0.33} \\cdot\\left\\(\\frac{\\mu\\_{l}}{\\mu\\_{\\text {IT }}}\\right\\)^{0.14}$$  

- Comments:   
   
### Convective heat transfer coefficient in zones 2 and 3 corresponding to the condensation zone  

- Mathematical formulation:   

$$   h_{\\text{cond} 2}=\\left\\{   \\begin{array}{ll}1,13 . \\mathrm{COPv} \\cdot\\left[\\frac{g \\cdot \\rho_{l}\\left(\\rho_{l}-\\rho_{v}\\right) \\lambda_{l}^{3} \\cdot h_{f g}}{L_{2} \\cdot \\mu_{l}\\left(T_{s a t}-T_{w 2}\\right)}\\right]^{0,25}  \\text{for vertical cavity} \\\\   0,728 \\cdot \\mathrm{COPv} \\cdot\\left[\\frac{g \\cdot \\rho_{l}\\left(\\rho_{l}-\\rho_{v}\\right) \\lambda_{l}^{3} \\cdot h_{f g}}{N t_{n} \\cdot \\mu_{l}\\left(T_{s a t}-T_{w 2}\\right) D_{e}}\\right]^{0,25}  \\text{for horizontal cavity} \\\\   \\end{array}\\right.$$  
$$   h_{\\text{cond} 3}=\\left\\{   \\begin{array}{ll}1,13 . \\mathrm{COPv} \\cdot\\left[\\frac{g \\cdot \\rho_{l}\\left(\\rho_{l}-\\rho_{v}\\right) \\lambda_{l}^{3} \\cdot h_{f g}}{L_{3} \\cdot \\mu_{l}\\left(T_{s a t}-T_{w 3}\\right)}\\right]^{0,25}  \\text{for vertical cavity } \\\\ 0,728 \\cdot \\mathrm{COPv} \\cdot\\left[\\frac{g \\cdot \\rho_{l}\\left(\\rho_{l}-\\rho_{v}\\right) \\lambda_{l}^{3} \\cdot h_{f g}}{N t_{n} \\cdot \\mu_{l}\\left(T_{s a t}-T_{w 3}\\right) D_{e}}\\right]^{0,25}  \\text{for horizontal cavity }   \\end{array}\\right.$$  

## References   
   
El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 14.4. Springer Nature Switzerland AG.  
    ", revisions = "
Authors  

Baligh El Hefni  
Daniel Bouskela   

    "));
end TwoPhaseCavity;