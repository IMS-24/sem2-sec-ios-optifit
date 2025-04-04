import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ExerciseMuscleView: View {
    // Instead of just muscles we now pass the muscle mapping
    // so we have access to intensity and the embedded muscleDto.
    var muscleMapping: [Components.Schemas.GetExerciseMuscleMappingDto]?

    //    var defaultBackImage = "Body outline with no background"
    //    var defaultFrontImage = "Body outline with white background"
    //
    //    // MARK: - Mapping functions
    //
    //    func frontImageName(code: String) -> String {
    //        switch code {
    //        case "pectoralis_major":
    //            return "Pectoralis Major"  // from front list
    //        case "biceps_brachii":
    //            return "Biceps brachii"  // from front list
    //        case "deltoid_lateral", "deltoid_posterior", "deltoid_anterior":
    //            return "Deltoids"  // available in both lists
    //        case "serratus_anterior":
    //            return "Serratus Anterior"  // available in both lists
    //        case "trapezius":
    //            return "Trapezius"  // available in both lists
    //        default:
    //            return defaultFrontImage  // fallback to default front image
    //        }
    //    }
    //
    //    func backImageName(code: String) -> String {
    //        switch code {
    //        case "infraspinatus":
    //            return "Infraspinatus"  // from back list
    //        case "deltoid_lateral", "deltoid_posterior", "deltoid_anterior":
    //            return "Deltoids"  // available in both lists
    //        case "erector_spinae":
    //            return defaultBackImage  // no explicit image provided
    //        case "teres_major":
    //            return "Teres major"  // from back list
    //        case "pectoralis_minor":
    //            return defaultBackImage  // no explicit image provided
    //        case "triceps_brachii":
    //            return "Triceps Brachii ( long head, lateral head )"  // from back list
    //        case "rhomboids":
    //            return "Rhomboid major"  // from back list
    //        case "latissimus_dorsi":
    //            return "Lattisimus dorsi"  // from back list
    //        case "trapezius":
    //            return "Trapezius"  // available in both lists
    //        case "teres_minor":
    //            return defaultBackImage  // no explicit image provided
    //        case "serratus_anterior":
    //            return "Serratus Anterior"  // available in both lists
    //        default:
    //            return defaultBackImage  // fallback to default back image
    //        }
    //    }
    //
    //    // MARK: - Intensity to Color
    //
    //    /// Maps an intensity (0...100) to a Color.
    //    /// Low intensity will be greener; high intensity, redder.
    //    func colorForIntensity(_ intensity: Int32) -> Color {
    //        let clampedIntensity = min(max(intensity, 0), 100)
    //        let normalized = Double(clampedIntensity) / 100.0
    //        return Color(red: normalized, green: 1.0 - normalized, blue: 0)
    //    }
    //
    //    // MARK: - Aggregating Intensities
    //
    //    /// Groups front images by their image name and sums the intensities.
    //    var frontImageIntensities: [String: Int32] {
    //        var dict: [String: Int32] = [:]
    //        muscleMapping?.forEach { mapping in
    //            if let code = mapping.muscleDto?.i18NCode,
    //                let intensity = mapping.intensity
    //            {
    //                let imageName = frontImageName(code: code)
    //                dict[imageName, default: 0] += intensity
    //            }
    //        }
    //        return dict
    //    }
    //
    //    /// Groups back images by their image name and sums the intensities.
    //    var backImageIntensities: [String: Int32] {
    //        var dict: [String: Int32] = [:]
    //        muscleMapping?.forEach { mapping in
    //            if let code = mapping.muscleDto?.i18NCode,
    //                let intensity = mapping.intensity
    //            {
    //                let imageName = backImageName(code: code)
    //                dict[imageName, default: 0] += intensity
    //            }
    //        }
    //        return dict
    //    }

    // MARK: - View Body

    var body: some View {
        VStack(spacing: 20) {
            MuscleImagesView(muscle: muscleMapping?.first?.muscleDto)
        }
    }
}
