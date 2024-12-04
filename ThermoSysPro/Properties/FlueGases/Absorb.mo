within ThermoSysPro.Properties.FlueGases;
function Absorb "Flue gases - particles emissivity"
  extends ThermoSysPro.Properties.FlueGases.unsafeForJacobian;
  input Units.SI.AbsolutePressure PC "CO2 partial pressure";
  input Units.SI.AbsolutePressure PW "H2O partial pressure";
  input Real FV "Volume concentration of the particules";
  input Units.SI.Length L "Optical path";
  input Units.SI.Temperature T "Temperature";
  output Real EG " ";
  output Real ES " ";
  output Real emigaz "Gas emissivity";

  external "FORTRAN" absorb(PC,PW,FV,L,T,EG,ES,emigaz);
  annotation (Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2024</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 4.1</b></p>
</HTML>
"));
end Absorb;
