namespace ProjetFinal__2037266.ViewModels
{
    public class ProcedureConducteurViewModel
    {
        public int ConducteurID { get; set; }

        public string Nom { get; set; }

        public string Prenom { get; set; }

        public DateOnly DateNaissance { get; set; }
        public string PaysOrigine { get; set; }
        public int NombreVictoires { get; set; }
    }
}
