within ThermoSysPro.Fluid.Examples.SimpleExamples.Machines;
model TestStodolaTurbine
  extends ThermoSysPro.UsersGuide.Icons.Example;

  ThermoSysPro.Fluid.Machines.StodolaTurbine stodolaTurbine(Cst=400000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  ThermoSysPro.Fluid.BoundaryConditions.SourcePQ sourcePQ(
    P0=4500000,
    Q0=1800,
    T0=573.15,
    option_temperature=true)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  ThermoSysPro.Fluid.BoundaryConditions.Sink sink
    annotation (Placement(transformation(extent={{26,-10},{46,10}})));
equation
  connect(sourcePQ.C, stodolaTurbine.Ce)
    annotation (Line(points={{-30,0},{-10.1,0}}, color={0,0,0}));
  connect(stodolaTurbine.Cs, sink.C)
    annotation (Line(points={{10.1,0},{26,0}}, color={0,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TestStodolaTurbine;
