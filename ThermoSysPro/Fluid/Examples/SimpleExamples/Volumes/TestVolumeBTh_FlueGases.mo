within ThermoSysPro.Fluid.Examples.SimpleExamples.Volumes;
model TestVolumeBTh_FlueGases
  extends ThermoSysPro.UsersGuide.Icons.Example;

  replaceable package Medium = Properties.Media.FlueGases;
  ThermoSysPro.Fluid.BoundaryConditions.Sink sink(redeclare replaceable package
      Medium =                                                                           Medium,
    T0=573.15,
    option_temperature=true)                                                                     annotation (Placement(transformation(extent={{-10,-10},
            {10,10}},
        rotation=90,
        origin={0,40})));
  ThermoSysPro.Fluid.BoundaryConditions.SourcePQ sourcePQ(redeclare
      replaceable package Medium =                                                               Medium,
    P0=4500000,
    T0=573.15,
    option_temperature=true)                                                                             annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  ThermoSysPro.Fluid.Volumes.VolumeBTh
                                     volumeBTh(
                                             redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  ThermoSysPro.Fluid.BoundaryConditions.SourceQ sourceQ(redeclare replaceable
      package Medium =                                                                         Medium,
    T0=573.15,
    option_temperature=true)                                                                           annotation (Placement(transformation(extent={{-10,-10},
            {10,10}},
        rotation=180,
        origin={40,0})));
equation
  connect(sourcePQ.C, volumeBTh.Ce1)
    annotation (Line(points={{-30,0},{-10,0}}, color={0,0,0}));
  connect(volumeBTh.Ce2, sourceQ.C) annotation (Line(points={{10,0},{25,0},{25,
          6.66134e-16},{30,6.66134e-16}}, color={0,0,0}));
  connect(volumeBTh.Cs1, sink.C) annotation (Line(points={{0,10},{0,20},{
          -5.55112e-16,20},{-5.55112e-16,30}}, color={0,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end TestVolumeBTh_FlueGases;
