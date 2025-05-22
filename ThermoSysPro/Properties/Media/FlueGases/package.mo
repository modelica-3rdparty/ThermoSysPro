within ThermoSysPro.Properties.Media;
package FlueGases "Flue gases library inherited from Modelica.Media"
  import Modelica.Media.Interfaces.Choices.ReferenceEnthalpy;

  extends PartialSubCMedium(nSubC=nC,isCompressible=true);
  extends Modelica.Media.IdealGases.Common.MixtureGasNasa(
    mediumName="MediaMonomeld",
    data={Modelica.Media.IdealGases.Common.SingleGasesData.N2,Modelica.Media.IdealGases.Common.SingleGasesData.O2,
          Modelica.Media.IdealGases.Common.SingleGasesData.H2O,Modelica.Media.IdealGases.Common.SingleGasesData.CO2,
          Modelica.Media.IdealGases.Common.SingleGasesData.SO2},
    fluidConstants={Modelica.Media.IdealGases.Common.FluidData.N2,Modelica.Media.IdealGases.Common.FluidData.O2,
                    Modelica.Media.IdealGases.Common.FluidData.H2O,Modelica.Media.IdealGases.Common.FluidData.CO2,
                    Modelica.Media.IdealGases.Common.FluidData.SO2},
    substanceNames={"Nitrogen","Oxygen","Water","Carbondioxide","Sulfurdioxide"},
    reference_X={0.768,0.232,0.0,0.0,0.0},
    referenceChoice=ReferenceEnthalpy.UserDefined,
    h_offset = hr - hr_FlueGases + Modelica.Media.IdealGases.Common.SingleGasesData.H2O.H0);

    constant Units.SI.SpecificEnthalpy hr=2501569 "ThermoSysPro Water/steam reference specific enthalpy at 0.01°C";
    constant Units.SI.SpecificEnthalpy hr_FlueGases=503298 "FlueGases reference specific enthalpy, computed from ThermoSysPro.Properties.ModelicaMediaFlueGases.specificEnthalpy(state0) at (0.006112 bars, 0.01°C)";

  annotation (Documentation(info="<html>

</html>"));
end FlueGases;
