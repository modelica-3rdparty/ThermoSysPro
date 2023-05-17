within ThermoSysPro.Examples.SimpleExamples;
model TestVolumeA_HomogeneousSubstance

  parameter Real Coeff(fixed=false, start=10);
  parameter ThermoSysPro.Units.SI.MassFlowRate Qmain=5000;

  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss1(redeclare package Species =
        ThermoSysPro.ConvectedQuantities.Substances.HomogeneousSubstance)
    annotation (Placement(transformation(extent={{48,-50},{68,-30}})));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss2(
    K = Coeff,
    redeclare package Species =
        ThermoSysPro.ConvectedQuantities.Substances.HomogeneousSubstance,
    Q(fixed=true, start=Qmain))
    annotation (Placement(transformation(extent={{-78,-50},{-58,-30}})));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourcePmain(
    P0=300000,
    option_temperature=2,
    redeclare package Species =
        ThermoSysPro.ConvectedQuantities.Substances.HomogeneousSubstance)
    annotation (Placement(transformation(extent={{-156,-50},{-136,-30}})));
  ThermoSysPro.WaterSteam.Volumes.VolumeA volumeA(
    V=100,
    dynamic_mass_balance=true,
    steady_state=true,
    redeclare package Species =
        ThermoSysPro.ConvectedQuantities.Substances.HomogeneousSubstance)
    annotation (Placement(transformation(
        extent={{-12,-13},{12,13}},
        rotation=0,
        origin={0,-41})));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP(
    h0(fixed=true) = 100000,
    Cin={100},
    redeclare package Species =
        ThermoSysPro.ConvectedQuantities.Substances.HomogeneousSubstance)
    annotation (Placement(transformation(extent={{-126,-10},{-106,10}})));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP sinkP(redeclare package
      Species =
        ThermoSysPro.ConvectedQuantities.Substances.HomogeneousSubstance)
    annotation (Placement(transformation(extent={{98,-50},{118,-30}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe rampe(
    Starttime=5,
    Duration=6,
    Initialvalue=0,
    Finalvalue=1)
    annotation (Placement(transformation(extent={{-160,10},{-140,30}})));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve controlValve(redeclare
      package Species =
        ThermoSysPro.ConvectedQuantities.Substances.HomogeneousSubstance)
    annotation (Placement(transformation(extent={{-78,-4},{-58,16}})));
equation
  connect(singularPressureLoss2.C2, volumeA.Ce1)
    annotation (Line(points={{-58,-40},{-36,-40},{-36,-41},{-12,-41}},
                                                   color={0,0,255}));
  connect(volumeA.Cs1, singularPressureLoss1.C1)
    annotation (Line(points={{12,-41},{30,-41},{30,-40},{48,-40}},
                                                 color={0,0,255}));
  connect(singularPressureLoss1.C2, sinkP.C)
    annotation (Line(points={{68,-40},{98,-40}}, color={0,0,255}));
  connect(sourcePmain.C, singularPressureLoss2.C1)
    annotation (Line(points={{-136,-40},{-78,-40}}, color={0,0,255}));
  connect(sourceP.C, controlValve.C1)
    annotation (Line(points={{-106,0},{-78,0}}, color={0,0,255}));
  connect(controlValve.C2, volumeA.Ce2)
    annotation (Line(points={{-58,0},{0,0},{0,-28}}, color={0,0,255}));
  connect(rampe.y, controlValve.Ouv)
    annotation (Line(points={{-139,20},{-68,20},{-68,17}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
            {160,60}})), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-200,-100},{160,60}})));
end TestVolumeA_HomogeneousSubstance;
