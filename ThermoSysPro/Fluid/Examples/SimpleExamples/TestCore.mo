within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestCore
  parameter Integer TubesNumber=Rods_per_FA*numberFA;
  parameter Integer numberFA=101 "Number of fuel assemblies ";
  parameter Integer Rods_per_FA=265 "Number of fuel rod per assembly";

  parameter ThermoSysPro.Units.SI.MassFlowRate NominalFlow=5573 "Primary Mass Flow Rate";
  parameter ThermoSysPro.Units.SI.Temperature T_inletCore=295 + 273.15 "Core Inlet Temperature";
  parameter ThermoSysPro.Units.SI.Temperature T_outletCore=330 + 273.15 "Core Outlet Temperature";
  parameter ThermoSysPro.Units.SI.Power MaximumPower=1150e6 "Power of the core at 100%";
  parameter ThermoSysPro.Units.SI.Pressure NominalPressure=15500000 "Pressure inside the core";

  parameter Integer n_rods=2 "Number of control rods";

  ThermoSysPro.Fluid.HeatExchangers.DynamicOnePhaseFlowPipe PrimaryCoolantFlow_Core(
    L=3,
    D=1.05,
    rugosrel=1e-6,
    z1=0,
    z2=3,
    Ns=6,
    simplified_dynamic_energy_balance=true,
    inertia=false,
    dynamic_mass_balance=false,
    continuous_flow_reversal=false,
    P(start={15500000.0,15496833.0,15493688.0,15490602.0,15487600.0,15484687.0,15481844.0,15479026.0}),
    h(start={1310627.6,1324450.5,1362215.6,1413803.6,1465391.6,1503156.6,1516979.6,1517208.8}),
    Q(start=fill(NominalFlow, 7))) annotation (Placement(transformation(
        extent={{-19,-20},{19,20}},
        rotation=90,
        origin={0,-9})));

  ThermoSysPro.NuclearCore.FuelThermalPower Fuel_Thermal_Power(
    isMOX=true,
    Rods_per_FA=Rods_per_FA,
    FA=numberFA,
    Rp=4.05765e-3,
    Rclad=4.1402e-3,
    Length=2.86,
    steady_state=true,
    Tstart=1129.15,
    T(start={{2772.556884765625,2735.8642578125,2699.28076171875,2662.016357421875,2553.491455078125},
      {6077.80078125,6076.91943359375,6076.06005859375,6075.203125,2553.491455078125},
      {7968.857421875,7968.8095703125,7968.76318359375,7968.716796875,2553.491455078125},
      {7829.7568359375,7829.6962890625,7829.63720703125,7829.57861328125,2553.491455078125},
      {5808.892578125,5807.50048828125,5806.14208984375,5804.7861328125,2553.491455078125},
      {2671.19384765625,2632.07666015625,2593.121337890625,2553.491455078125,2553.491455078125}}),
    Wcond(start=fill(
          MaximumPower/(6*6),
          6,
          6))) annotation (Placement(transformation(extent={{-142,-20},{-118,4}})));
  ThermoSysPro.Thermal.HeatTransfer.HeatExchangerWall heatExchangerWallCounterFlow(
    L=2,
    D=0.0082804,
    e=6.0960e-4,
    Ns=6,
    rhow(displayUnit="kg/m3") = 6500,
    steady_state=true,
    ntubes=TubesNumber) annotation (Placement(transformation(
        extent={{-16,-16},{16,16}},
        rotation=90,
        origin={-54,-8})));
  ThermoSysPro.NuclearCore.NeutronKinetics Neutron_Kinetics(
    Tlife=10e-4,
    Ptot0=MaximumPower,
    Pneut(start=MaximumPower)) annotation (Placement(transformation(extent={{-240,-20},{-200,20}})));
  ThermoSysPro.NuclearCore.DecayHeat Residual_Power(steady_state=true, Pneut(start=MaximumPower)) annotation (Placement(transformation(extent={{-236,-76},{-200,-40}})));
  ThermoSysPro.NuclearCore.ReactivityFeedbacks Reactivity_Feedbacks(n_rods=n_rods) annotation (Placement(transformation(extent={{-240,40},{-200,80}})));
  ThermoSysPro.Fluid.Sensors.SensorT sensorTin(Q(start=NominalFlow)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-8,-66})));
  ThermoSysPro.Fluid.Sensors.SensorT sensorTout(Q(start=NominalFlow)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-8,58})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Math.Add Tmoy(k1=0.5, k2=0.5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-60,52})));
  ThermoSysPro.NuclearCore.Xenon xenon annotation (Placement(transformation(extent={{-182,6},{-162,26}})));
  Fluid.BoundaryConditions.SourceP sourceP(P0=NominalPressure, T0=T_inletCore) annotation (Placement(transformation(extent={{-52,-96},{-32,-76}})));
  Fluid.BoundaryConditions.SinkQ sinkQ(
    Q0=NominalFlow,
    T0=T_outletCore,
    option_temperature=true,
    C(Q(start=NominalFlow))) annotation (Placement(transformation(extent={{20,70},{40,90}})));
  InstrumentationAndControl.Blocks.Math.Feedback ERROR_T annotation (Placement(transformation(extent={{-86,154},{-66,174}})));
  InstrumentationAndControl.Blocks.Sources.Constante Tmoy_target(k=(T_inletCore + T_outletCore)/2) annotation (Placement(transformation(extent={{-140,174},{-120,194}})));
  InstrumentationAndControl.Blocks.Math.Gain gain(Gain=-32.24) annotation (Placement(transformation(extent={{-8,154},{12,174}})));
  InstrumentationAndControl.Blocks.NonLineaire.BandeMorte bandeMorte(uMax=0.5, uMin=-0.5) annotation (Placement(transformation(extent={{-44,154},{-24,174}})));
  InstrumentationAndControl.Blocks.NonLineaire.Limiteur limiteur(maxval=72, minval=-72) annotation (Placement(transformation(extent={{26,154},{46,174}})));
  InstrumentationAndControl.Blocks.Sources.Constante cst(k=0) annotation (Placement(transformation(extent={{-330,42},{-310,62}})));
equation

  connect(Neutron_Kinetics.DecayHeat, Residual_Power.DecayHeat) annotation (Line(points={{-242,-8},{-250,-8},{-250,-34},{-194,-34},{-194,-58},{-198.2,-58}}, color={0,0,255}));
  connect(Neutron_Kinetics.Pneutrons, Residual_Power.Pneutrons) annotation (Line(points={{-198,10},{-190,10},{-190,-84},{-242,-84},{-242,-58},{-237.8,-58}}, color={0,0,255}));
  connect(Reactivity_Feedbacks.SortieReac, Neutron_Kinetics.Reactivity) annotation (Line(points={{-198,58.8},{-190,58.8},{-190,26},{-244,26},{-244,8},{-242,8}}, color={0,0,255}));
  connect(Fuel_Thermal_Power.Teff_fuel, Reactivity_Feedbacks.EntreeT_fuel) annotation (Line(points={{-130,5.2},{-130,88},{-250,88},{-250,68},{-242,68}}, color={0,0,255}));
  connect(Fuel_Thermal_Power.C_clad, heatExchangerWallCounterFlow.WT2) annotation (Line(points={{-116.8,-8.12},{-87,-8.12},{-87,-8},{-57.2,-8}}, color={0,0,0}));
  connect(heatExchangerWallCounterFlow.WT1, PrimaryCoolantFlow_Core.CTh) annotation (Line(points={{-50.8,-8},{-6,-8},{-6,-9}}, color={0,0,0}));
  connect(Tmoy.u2, sensorTout.Measure) annotation (Line(
      points={{-49,58},{-18.2,58}},
      color={0,0,255},
      pattern=LinePattern.Dot));
  connect(Tmoy.u1, sensorTin.Measure) annotation (Line(
      points={{-49,46},{-28,46},{-28,-66},{-18.2,-66}},
      color={0,0,255},
      pattern=LinePattern.Dot));
  connect(Tmoy.y, Reactivity_Feedbacks.EntreeT_CoreAv) annotation (Line(
      points={{-71,52},{-76,52},{-76,92},{-252,92},{-252,60},{-242,60}},
      color={0,0,255},
      pattern=LinePattern.Dot));
  connect(Neutron_Kinetics.TotalPower, Fuel_Thermal_Power.Wt_fuel) annotation (Line(points={{-198,3.2},{-188,3.2},{-188,-8},{-143.2,-8}}, color={0,0,255}));
  connect(sensorTout.C1, PrimaryCoolantFlow_Core.C2) annotation (Line(points={{0,48},{0,10}}, color={0,0,0}));
  connect(PrimaryCoolantFlow_Core.C1, sensorTin.C2) annotation (Line(points={{0,-28},{0,-55.8}}, color={0,0,0}));
  connect(Neutron_Kinetics.Pneutrons, xenon.Power) annotation (Line(points={{-198,10},{-190,10},{-190,16},{-180.2,16}}, color={0,0,255}));
  connect(xenon.Xe135, Reactivity_Feedbacks.EntreeCxenon) annotation (Line(points={{-163.8,11.8},{-156,11.8},{-156,32},{-250,32},{-250,44},{-242,44}}, color={0,0,255}));
  connect(sensorTout.C2, sinkQ.C) annotation (Line(points={{0,68.2},{0,80},{20,80}}, color={0,0,0}));
  connect(sensorTin.C1, sourceP.C) annotation (Line(points={{0,-76},{0,-86},{-32,-86}}, color={0,0,0}));
  connect(Tmoy_target.y, ERROR_T.u1) annotation (Line(points={{-119,184},{-94,184},{-94,164},{-87,164}}, color={0,0,255}));
  connect(ERROR_T.y, bandeMorte.u) annotation (Line(points={{-65,164},{-45,164}}, color={0,0,255}));
  connect(bandeMorte.y, gain.u) annotation (Line(points={{-23,164},{-9,164}}, color={0,0,255}));
  connect(gain.y, limiteur.u) annotation (Line(points={{13,164},{25,164}}, color={0,0,255}));
  connect(Tmoy.y, ERROR_T.u2) annotation (Line(
      points={{-71,52},{-76,52},{-76,153}},
      color={0,0,255},
      pattern=LinePattern.Dot));
  connect(limiteur.y, Reactivity_Feedbacks.RodsSpeeds[1]) annotation (Line(points={{47,164},{56,164},{56,212},{-332,212},{-332,75.5},{-242,75.5}}, color={0,0,255}));
  connect(limiteur.y, Reactivity_Feedbacks.RodsSpeeds[2]) annotation (Line(points={{47,164},{56,164},{56,212},{-332,212},{-332,76.5},{-242,76.5}}, color={0,0,255}));
  connect(Reactivity_Feedbacks.EntreeCbore, cst.y) annotation (Line(points={{-242,52},{-309,52}}, color={0,0,255}));
  annotation (
    experiment(StopTime=1000),
    Icon(graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Polygon(
          origin={8.0,14.0},
          lineColor={78,138,73},
          fillColor={78,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2024 </p>
<p><b>ThermoSysPro Version 4.1 </h4>
</html>"),
    Diagram(coordinateSystem(extent={{-340,-100},{100,220}})));
end TestCore;
