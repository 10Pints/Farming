namespace Bagnan1_AreaCalc
{
   internal class Program
   {
      /// <summary>
      /// The main entry point for the calculation
      /// </summary>
      /// <param name="args"></param>
      static void Main(string[] args)
      {
         // Inialise the calculator
         Bagnan1Calc.Init();

         // Calc the area in sq meters
         double d1 = Bagnan1Calc.AreaCalcM2();

         // Calc the area in hectares
         double d2 = Bagnan1Calc.AreaCalcHa();
         Console.WriteLine($"The area of Bagnana 1 is {d1} square meters");
         Console.WriteLine($"The area of Bagnana 1 is {d2} hectares");
      }
   }
}