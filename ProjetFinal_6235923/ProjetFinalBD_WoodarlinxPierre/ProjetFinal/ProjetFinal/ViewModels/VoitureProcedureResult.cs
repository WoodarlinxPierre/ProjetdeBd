namespace ProjetFinal__6235923.ViewModels
{
    public class VoitureProcedureResult
    {
    
        public int VoitureID { get; set; }
        public string Modele { get; set; }
        public decimal Prix { get; set; }
        public int Kilometrage { get; set; }
        public string TypeCarburant { get; set; }
        public string Categorie { get; set; } = null!;
        public bool Disponible { get; set; }

    }
}
