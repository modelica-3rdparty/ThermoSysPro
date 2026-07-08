within ThermoSysPro.WaterSteam.HeatExchangers;
model SteamGenerator_1SG "Individual steam generator"

  parameter Integer Ns=5 "Number of segments in tubes and riser" annotation (Dialog(tab="General", group="Geometry"));

  parameter Integer n_tubes=4085 "Number of pipes in parallel" annotation (Dialog(tab="General", group="Geometry"));
  parameter ThermoSysPro.Units.SI.Area S=4669 "Heat exchange area" annotation (Dialog(tab="General", group="Geometry"));
  parameter ThermoSysPro.Units.SI.Length e_tubes=1.2e-3 "Pipe's wall thickness" annotation (Dialog(tab="General", group="Geometry"));
  parameter ThermoSysPro.Units.SI.Length Dext_tubes=22.0e-3 "Pipe's external Diameter" annotation (Dialog(tab="General", group="Geometry"));
  parameter ThermoSysPro.Units.SI.Length Leq=S/(n_tubes*(Dext_tubes - 2*e_tubes)*Modelica.Constants.pi) "Equivalent length for pipes and riser" annotation (Dialog(tab="General", group="Geometry"));
  parameter Real hcCorr=5.0 "Corrective term for the heat exchange coefficient (hc) inside all pipes - to tune correct Tcold_primary" annotation (Dialog(tab="General", group="Geometry"));

  parameter ThermoSysPro.Units.SI.Volume V_sep=7.0 "Volume of the separator" annotation (Dialog(tab="General", group="Separator: from Riser volume to Dome"));
  parameter ThermoSysPro.Units.SI.Length L_sep=3.0 "Length of the separator" annotation (Dialog(tab="General", group="Separator: from Riser volume to Dome"));
  parameter ThermoSysPro.Units.SI.Length D_sep=fromVtoDeq(V_sep, L_sep, 1) "Equivalent diameter of the separator (considered one pipe)" annotation (Dialog(tab="General", group="Separator: from Riser volume to Dome"));

  parameter ThermoSysPro.Units.SI.Volume V_Riser=45.0 "Riser's volume " annotation (Dialog(tab="General", group="Riser (Tube bundle in the secondary)"));
  parameter ThermoSysPro.Units.SI.Length D_Riser=fromVtoDeq(
      V_Riser,
      Leq/2,
      n_tubes) "Equivalent diameter of the riser" annotation (Dialog(tab="General", group="Riser (Tube bundle in the secondary)"));
  parameter Real K_riser=10 "Pressure loss coefficient to tune correct recirculation rate" annotation (Dialog(tab="General", group="Riser (Tube bundle in the secondary)"));

  parameter ThermoSysPro.Units.SI.Volume V_Dome=60.0 "Volume of the dome" annotation (Dialog(tab="General", group="Dome"));
  parameter ThermoSysPro.Units.SI.Length L_Dome=5.0 "Length of the dome" annotation (Dialog(tab="General", group="Dome"));
  parameter ThermoSysPro.Units.SI.Length R_Dome=sqrt(V_Dome/(L_Dome*Modelica.Constants.pi)) "Radius of the dome" annotation (Dialog(tab="General", group="Dome"));

  parameter ThermoSysPro.Units.SI.Volume V_DownComer=8.0 "Volume of the downcomer" annotation (Dialog(tab="General", group="DownComer"));
  parameter ThermoSysPro.Units.SI.Diameter Dint_DownComer=4.0 "Inner diameter of the annular downcomer" annotation (Dialog(tab="General", group="DownComer"));
  final parameter AnnularHydraulicEquivalence downComerHydraulicEquivalence=
      fromAnnularVtoHydraulicEquivalence(
        V_DownComer,
        Leq/2,
        Dint_DownComer);
  final parameter ThermoSysPro.Units.SI.Diameter Dh_DownComer=
      downComerHydraulicEquivalence.Dh "Hydraulic diameter of the annular downcomer";
  final parameter Real neq_DownComer=downComerHydraulicEquivalence.neq
      "Equivalent number of circular pipes preserving the downcomer flow area";

  parameter ThermoSysPro.Units.SI.Volume V_MixARE=12.0 "Volume where feedwater mixes with recirculation" annotation (Dialog(tab="General", group="MixARE"));

  Real CirculationRate "Circulation rate";
  ThermoSysPro.Units.SI.Power W_GV_primary "Power from primary to SG";
  ThermoSysPro.Units.SI.Power W_GV_secondary "Power from SG to secondary";
  DynamicOnePhaseFlowPipe UtubeHotLeg(

    L=Leq/2,
    D=Dext_tubes - 2*e_tubes,
    ntubes=n_tubes,
    z2=Leq/2,
    hcCorr=hcCorr,
    Ns=Ns,

    option_temperature=2,
    mode=0,
    steady_state=true,
    inertia=false,
    dpfCorr=0.17) annotation (Placement(transformation(
        origin={-80,-50},
        extent={{30,-20},{-30,20}},
        rotation=270)));
  DynamicOnePhaseFlowPipe UtubeColdLeg(
    L=Leq/2,
    D=Dext_tubes - 2*e_tubes,
    ntubes=n_tubes,
    z1=Leq/2,
    hcCorr=hcCorr,
    Ns=Ns,
    option_temperature=2,
    mode=0,
    steady_state=true,
    inertia=false,
    dpfCorr=0.17) annotation (Placement(transformation(
        origin={65,-50},
        extent={{30,-15},{-30,15}},
        rotation=90)));
  Volumes.DynamicDrum DomeGV(
    steady_state=true,
    cpp=500,
    L=L_Dome,
    Vf0=0.1,
    R=R_Dome,
    Mp=32000) annotation (Placement(transformation(extent={{22,68},{-22,111}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe DPSeparateurCyclone(
    L=L_sep,
    D=D_sep,
    z2=L_sep,
    lambda=0.03) annotation (Placement(transformation(
        origin={0,38},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ThermoSysPro.WaterSteam.Volumes.VolumeC MixAlimDomeGV(
    steady_state=true,
    V=V_MixARE,
    dynamic_mass_balance=false) " " annotation (Placement(transformation(
        origin={94,63},
        extent={{-8,-8},{8,8}},
        rotation=270)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss DPnulle_AlimDwnc(K=1e-4) annotation (Placement(transformation(
        origin={94,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss DPnulle_DomeDwnc(
    p_rho=0,
    mode=0,
    K=0.172144) annotation (Placement(transformation(extent={{52,54},{70,72}}, rotation=0)));
  ThermoSysPro.WaterSteam.Sensors.SensorP CapteurPAlim annotation (Placement(transformation(
        origin={101,30},
        extent={{-10,-9},{10,9}},
        rotation=270)));
  ThermoSysPro.WaterSteam.Connectors.FluidOutletI fluidOutletI annotation (Placement(transformation(extent={{-10,139},{10,159}}, rotation=0)));
  ThermoSysPro.WaterSteam.Connectors.FluidInletI fluidInlet annotation (Placement(transformation(extent={{42,100},{62,120}}, rotation=0), iconTransformation(extent={{42,100},{62,120}})));
  ThermoSysPro.WaterSteam.Connectors.FluidInletI fluidInlet1 annotation (Placement(transformation(extent={{-60,-160},{-40,-140}}, rotation=0)));
  ThermoSysPro.WaterSteam.Connectors.FluidOutletI fluidOutletI1 annotation (Placement(transformation(extent={{40,-160},{60,-140}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal outputReal annotation (Placement(transformation(extent={{-42,80},{-62,100}}, rotation=0), iconTransformation(extent={{-42,80},{-62,100}})));
  PressureLosses.LumpedStraightPipe DownComerGV(
    p_rho=0,
    mode=1,
    L=Leq/2,
    D=Dh_DownComer,
    ntubes=neq_DownComer,
    z1=Leq/2,
    lambda=0.09) "DownComerGV" annotation (Placement(transformation(
        origin={94,-50},
        extent={{-30,20},{30,-20}},
        rotation=270)));
  Thermal.HeatTransfer.HeatExchangerWall heatExchangerWall(

    ntubes=UtubeHotLeg.ntubes,
    L=UtubeHotLeg.L,
    D=UtubeHotLeg.D,
    e=e_tubes,
    Ns=UtubeHotLeg.Ns,
    lambda=23,
    cpw=503,
    rhow=8430) annotation (Placement(transformation(
        origin={-40,-50},
        extent={{-30,-20},{30,20}},
        rotation=270)));
  Thermal.HeatTransfer.HeatExchangerWall heatExchangerWall1(
    ntubes=UtubeColdLeg.ntubes,
    L=UtubeColdLeg.L,
    D=UtubeColdLeg.D,
    e=e_tubes,
    Ns=UtubeColdLeg.Ns,
    lambda=23,
    cpw=503,
    rhow=8430) annotation (Placement(transformation(
        origin={41,-50},
        extent={{-30,17},{30,-17}},
        rotation=270)));

  DynamicTwoPhaseFlowRiser RiserGV(
    L=Leq/2,
    D=D_Riser,
    ntubes=n_tubes,
    z2=Leq/2,
    hcCorr=hcCorr,
    Ns=Ns,
    inertia=false,
    dpfCorr=1) annotation (Placement(transformation(
        origin={-3,-50},
        extent={{-30,31},{30,-31}},
        rotation=90)));
  Volumes.VolumeA volumeA(
    P0=68.4935e5,
    h0=1185.2e3,
    dynamic_mass_balance=true) annotation (Placement(transformation(
        origin={0,-120},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Volumes.VolumeC volumeA1(V=0.1, dynamic_mass_balance=true) annotation (Placement(transformation(
        origin={0,10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  PressureLosses.SingularPressureLoss DPnulle_Tcirc(
    p_rho=0,
    mode=0,
    K=K_riser) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-94})));
  Connectors.FluidOutletI fluidOutletI_purge annotation (Placement(transformation(extent={{140,-130},{160,-110}}, rotation=0), iconTransformation(extent={{36,-100},{56,-80}})));
  function fromVtoDeq
    input ThermoSysPro.Units.SI.Volume V;
    input ThermoSysPro.Units.SI.Length L;
    input Integer ntubes;
    output ThermoSysPro.Units.SI.Length D;
  algorithm
    D := sqrt((4*V)/(L*Modelica.Constants.pi*ntubes));
  end fromVtoDeq;

  record AnnularHydraulicEquivalence
    ThermoSysPro.Units.SI.Diameter Dh;
    Real neq;
  end AnnularHydraulicEquivalence;

  function fromAnnularVtoHydraulicEquivalence
    input ThermoSysPro.Units.SI.Volume V;
    input ThermoSysPro.Units.SI.Length L;
    input ThermoSysPro.Units.SI.Diameter Dint;
    output AnnularHydraulicEquivalence hydraulicEquivalence;
  protected
    ThermoSysPro.Units.SI.Area A;
    ThermoSysPro.Units.SI.Diameter Dext;
  algorithm
    assert(V > 0, "The annular volume must be strictly positive");
    assert(L > 0, "The annular length must be strictly positive");
    assert(Dint >= 0, "The annular inner diameter must be positive or zero");
    A := V/L;
    Dext := sqrt(Dint^2 + 4*A/Modelica.Constants.pi);
    hydraulicEquivalence.Dh := Dext - Dint;
    hydraulicEquivalence.neq :=
      A/(Modelica.Constants.pi*hydraulicEquivalence.Dh^2/4);
  end fromAnnularVtoHydraulicEquivalence;
equation
  CirculationRate = DownComerGV.Q/fluidOutletI.Q;
  W_GV_primary = (fluidInlet1.h - fluidOutletI1.h)*fluidInlet1.Q;
  W_GV_secondary = -(fluidInlet.h - fluidOutletI.h)*fluidInlet.Q;

  /* Unconnected connectors */
  if (cardinality(fluidOutletI_purge) == 1) then
    fluidOutletI_purge.Q = 0;
    fluidOutletI_purge.h = 1.e5;
    fluidOutletI_purge.a = true;
  end if;

  connect(UtubeHotLeg.C2, UtubeColdLeg.C1) annotation (Line(
      points={{-80,-20},{-80,-10},{65,-10},{65,-20}},
      color={127,0,0},
      thickness=0.5));
  connect(MixAlimDomeGV.Ce1, DPnulle_AlimDwnc.C2) annotation (Line(points={{94,71},{94,80}}, thickness=0.5));
  connect(DPnulle_DomeDwnc.C2, MixAlimDomeGV.Ce3) annotation (Line(
      points={{70,63},{86,63}},
      color={0,0,255},
      thickness=0.5));
  connect(MixAlimDomeGV.Cs, CapteurPAlim.C1) annotation (Line(
      points={{94,55},{93.8,48},{93.8,40}},
      color={0,0,255},
      thickness=0.5));
  connect(DPnulle_AlimDwnc.C1, fluidInlet) annotation (Line(points={{94,100},{94,112},{52,112}}));
  connect(fluidInlet1, UtubeHotLeg.C1) annotation (Line(
      points={{-50,-150},{-50,-136},{-80,-136},{-80,-80}},
      color={127,0,0},
      thickness=0.5));
  connect(UtubeColdLeg.C2, fluidOutletI1) annotation (Line(
      points={{65,-80},{65,-136},{50,-136},{50,-150}},
      color={127,0,0},
      thickness=0.5));
  connect(CapteurPAlim.C2, DownComerGV.C1) annotation (Line(
      points={{93.8,19.8},{93.8,4.9},{94,4.9},{94,-20}},
      color={0,0,255},
      thickness=0.5));
  connect(UtubeHotLeg.CTh, heatExchangerWall.WT1) annotation (Line(
      points={{-74,-50},{-44,-50}},
      color={191,95,0},
      thickness=0.5));
  connect(heatExchangerWall1.WT1, UtubeColdLeg.CTh) annotation (Line(
      points={{44.4,-50},{60.5,-50}},
      color={191,95,0},
      thickness=0.5));
  connect(DownComerGV.C2, volumeA.Ce1) annotation (Line(points={{94,-80},{94,-130},{0,-130}}, color={0,0,255}));
  connect(RiserGV.C2, volumeA1.Ce1) annotation (Line(points={{0.1,-20},{0.1,-10},{0,-10},{0,0}}, color={0,0,255}));
  connect(volumeA1.Cs, DPSeparateurCyclone.C1) annotation (Line(points={{0,20},{0,28}}, color={0,0,255}));
  connect(heatExchangerWall.WT2, RiserGV.CTh2) annotation (Line(points={{-36,-50},{-18.5,-50}}, color={191,95,0}));
  connect(RiserGV.CTh1, heatExchangerWall1.WT2) annotation (Line(points={{18.7,-50},{18.7,-48},{37.6,-48},{37.6,-50}}, color={191,95,0}));
  connect(DomeGV.Cv, fluidOutletI) annotation (Line(points={{-22,111},{-22,124},{0,124},{0,149}}, color={255,0,0}));
  connect(DPSeparateurCyclone.C2, DomeGV.Cm) annotation (Line(points={{0,48},{0,56},{-22,56},{-22,68}}, color={0,0,255}));
  connect(DomeGV.yLevel, outputReal) annotation (Line(points={{-24.2,89.5},{-32,89.5},{-32,96},{-52,96}}, color={0,0,255}));
  connect(volumeA.Cs1, DPnulle_Tcirc.C1) annotation (Line(points={{0,-110},{0,-104}}, color={0,0,255}));
  connect(DPnulle_Tcirc.C2, RiserGV.C1) annotation (Line(points={{0,-84},{0,-80},{0.1,-80}}, color={0,0,255}));
  connect(DPnulle_DomeDwnc.C1, DomeGV.Cd) annotation (Line(points={{52,63},{23,63},{23,68},{22,68}}, color={0,0,255}));
  connect(volumeA.Cs2, fluidOutletI_purge) annotation (Line(points={{10,-120},{150,-120}}, color={0,0,255}));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-150, -150}, {150, 150}}, initialScale = 0.1), graphics = {Text(extent = {{55, 81}, {55, 75}}, lineColor = {0, 0, 255}, textString = "petit DP"), Text(extent = {{-126, 153}, {-84, 123}}, lineColor = {0, 0, 255}, textString = "= 1 SG")}),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-150, -150}, {150, 150}}, initialScale = 0.1), graphics = {Ellipse(extent = {{-42, 150}, {42, 108}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.VerticalCylinder, fillColor = {0, 128, 255}), Rectangle(extent = {{-42, 131}, {42, 80}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.VerticalCylinder, fillColor = {0, 128, 255}), Ellipse(extent = {{-36, -108}, {36, -150}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.VerticalCylinder, fillColor = {0, 128, 255}), Rectangle(extent = {{-42, 86}, {42, 56}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.VerticalCylinder, fillColor = {170, 213, 255}), Rectangle(extent = {{-36, 42}, {36, -128}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.VerticalCylinder, fillColor = {170, 213, 255}), Polygon(points = {{-42, 56}, {42, 56}, {36, 42}, {-36, 42}, {-42, 56}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.VerticalCylinder, fillColor = {170, 213, 255})}),
    Documentation(revisions = "
Author  

Baligh El Hefni   

    ", info = "
## Copyright © EDF 2002 - 2026   
## ThermoSysPro Version 4.2  
    "));
end SteamGenerator_1SG;
