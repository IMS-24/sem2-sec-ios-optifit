import SwiftUI

struct MuscleImagesView: View {
    var muscle: Components.Schemas.GetMuscleDto?
    // Fallback image names
    var defaultBackImage = "Body outline with no background"
    var defaultFrontImage = "Body outline with white background"
    
    // Mapping for the front images (from the "front" list)
    var frontImageName: String {
        guard let code = muscle?.i18NCode else { return defaultFrontImage }
        switch code {
        case "pectoralis_major":
            return "Pectoralis Major"
        case "pectoralis_minor":
            return defaultFrontImage
        case "serratus_anterior":
            return "Serratus Anterior"
        case "biceps_brachii":
            return "Biceps brachii"
        case "deltoid_lateral", "deltoid_posterior", "deltoid_anterior":
            return "Deltoids"
        case "triceps_brachii":
            return "Triceps brachii, long head"
        case "infraspinatus":
            return defaultFrontImage
        case "erector_spinae":
            return defaultFrontImage
        case "teres_major":
            return defaultFrontImage
        case "teres_minor":
            return defaultFrontImage
        case "rhomboids":
            return defaultFrontImage
        case "latissimus_dorsi":
            return defaultFrontImage
        case "trapezius":
            return "Trapezius"
        case "rectus_femoris":
            return "Rectus femoris"
        case "rectus_abdominus":
            return "Rectus Abdominus"
        case "sternocleidomastoid":
            return "Sternocleidomastoid"
        case "vastus_medialis":
            return "Vastus Medialis"
        case "tensor_fasciae_latae":
            return "Tensor fasciae latae"
        case "flexor_carpi_ulnaris":
            return defaultFrontImage
        case "vastus_lateralis":
            return "Vastus Lateralis"
        case "soleus":
            return "Soleus"
        case "external_obliques":
            return "External obliques"
        case "gracilis":
            return defaultFrontImage
        case "extensor_carpi_radialis":
            return "Extensor carpi radialis"
        case "adductor_magnus":
            return defaultFrontImage
        case "lower_trapezius":
            return defaultFrontImage
        case "thoracolumbar_fascia":
            return defaultFrontImage
        case "adductor_longus_and_pectineus":
            return "Adductor Longus and Pectineus"
        case "brachialis":
            return "Brachialis"
        case "semitendinosus":
            return defaultFrontImage
        case "biceps_femoris":
            return defaultFrontImage
        case "gluteus_maximus":
            return defaultFrontImage
        case "sartorius":
            return "Sartorius"
        case "brachioradialis":
            return "Brachioradialis"
        case "gastrocnemius_lateral":
            return "Gastrocnemius (calf)"
        case "gluteus_medius":
            return defaultFrontImage
        case "rectus_abdominus_lower":
            return "Rectus Abdominus_lower"
        case "gastrocnemius_medial":
            return "Gastrocnemius (calf)"
        case "peroneus_longus":
            return "Peroneus longus"
        case "flexor_carpi_radialis":
            return "Flexor carpi radialis"
        case "omohyoid":
            return "Omohyoid"
        default:
            return defaultFrontImage
        }
    }
    
    // Mapping for the back images (from the "back" list)
    var backImageName: String {
        guard let code = muscle?.i18NCode else { return defaultBackImage }
        switch code {
        case "infraspinatus":
            return "Infraspinatus"
        case "deltoid_lateral", "deltoid_posterior", "deltoid_anterior":
            return "Deltoids"
        case "erector_spinae":
            return defaultBackImage
        case "teres_major":
            return "Teres major"
        case "pectoralis_minor":
            return defaultBackImage
        case "triceps_brachii":
            return "Triceps Brachii ( long head, lateral head )"
        case "rhomboids":
            return "Rhomboid major"
        case "latissimus_dorsi":
            return "Lattisimus dorsi"
        case "trapezius":
            return "Trapezius"
        case "teres_minor":
            return defaultBackImage
        case "serratus_anterior":
            return "Serratus Anterior"
        case "biceps_brachii":
            return defaultBackImage
        case "rectus_femoris":
            return defaultBackImage
        case "rectus_abdominus":
            return defaultBackImage
        case "sternocleidomastoid":
            return defaultBackImage
        case "vastus_medialis":
            return defaultBackImage
        case "tensor_fasciae_latae":
            return "Tensor fascie latae"
        case "flexor_carpi_ulnaris":
            return "Flexor carpi ulnaris"
        case "vastus_lateralis":
            return defaultBackImage
        case "soleus":
            return defaultBackImage
        case "external_obliques":
            return "External obliques"
        case "gracilis":
            return "Gracilis"
        case "extensor_carpi_radialis":
            return "Extensor carpi radialis"
        case "adductor_magnus":
            return "Adductor magnus"
        case "lower_trapezius":
            return "Lower Trapezius"
        case "thoracolumbar_fascia":
            return "Thoracolumbar fascia"
        case "adductor_longus_and_pectineus":
            return defaultBackImage
        case "brachialis":
            return defaultBackImage
        case "semitendinosus":
            return "Semitendinosus"
        case "biceps_femoris":
            return "Biceps fermoris"
        case "gluteus_maximus":
            return "Gluteus maximus"
        case "sartorius":
            return defaultBackImage
        case "brachioradialis":
            return "Brachioradialis"
        case "gastrocnemius_lateral":
            return "Gastrocnemius, lateral head"
        case "gluteus_medius":
            return "Gluteus medius"
        case "rectus_abdominus_lower":
            return defaultBackImage
        case "gastrocnemius_medial":
            return "Gastrocnemius, medial head"
        case "peroneus_longus":
            return "Peroneus longus"
        case "flexor_carpi_radialis":
            return "Flexor carpi radialis"
        case "omohyoid":
            return defaultBackImage
        default:
            return defaultBackImage
        }
    }
    
    
    var body: some View {
        // Display front and back images side-by-side.
        HStack(spacing: 16) {
            VStack {
                Text("Back")
                    .font(.headline)
                Image("Muscles/Male/Back/\(backImageName)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .cornerRadius(10)
            }
            VStack {
                Text("Front")
                    .font(.headline)
                Image("Muscles/Male/Front/\(frontImageName)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .cornerRadius(10)
            }
        }
    }
}
