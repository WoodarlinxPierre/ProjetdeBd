using System.ComponentModel.DataAnnotations;

namespace ProjetFinal__6235923.ViewModels
{
    public class ConnexionViewModel
    {
        [Required(ErrorMessage = "Veuillez préciser un courriel.")]
        public string Email { get; set; } = null!;

        [Required(ErrorMessage = "Veuillez entrer un mot de passe.")]
        [DataType(DataType.Password)]
        public string Mpd { get; set; } = null!;
    }
}
