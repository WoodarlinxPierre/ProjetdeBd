using System.ComponentModel.DataAnnotations;

namespace ProjetFinal__6235923.ViewModels
{
    public class InscriptionViewModel
    {
        [Required(ErrorMessage = "Une adresse courriel est requise.")]
        [DataType(DataType.EmailAddress)]
        public string Email { get; set; } = null!;

        [Required(ErrorMessage ="Un mot de passe est requis.")]
        [StringLength(50, MinimumLength =5 , ErrorMessage = "Le mot de passe doit avoir entre 5 et 50 caractères.")]
        [DataType(DataType.Password)]
        public string MotDePasse { get; set; } = null!;
        
        [Required(ErrorMessage = "Un mot de passe est requis.")]
        [StringLength(50, MinimumLength = 5, ErrorMessage = "Le mot de passe doit avoir entre 5 et 50 caractères.")]
        [DataType(DataType.Password)]
        public string MotDePasseConfirm { get; set; } = null!;

    }
}
