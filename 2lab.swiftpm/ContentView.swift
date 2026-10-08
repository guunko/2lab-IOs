import SwiftUI

enum CameraType: String {
    case DSLR, mirrorless, compact
}

func filterCamers(cameras: [Camera], pixelRate: Int) -> [Camera] {
    var results: [Camera] = []
    for object in cameras {
        guard let pixelRate = object.megapixels else { continue }
        if pixelRate >= Double(pixelRate) {
            results.append(object)
        }
    }
    
    return results
}

final class Camera: Identifiable {
    let id = UUID()
    let brand: String
    let model: String?
    let megapixels: Double?
    let type: CameraType

    init(brand: String, model: String?, megapixels: Double?, type: CameraType) {
        self.brand = brand
        self.model = model
        self.megapixels = megapixels
        self.type = type
    }

    func cameraDescription() -> String {

        let modelText: String

        if let model {
            modelText = model
        } else {
            modelText = "модель не вказана"
        }
        let megapixelsText = megapixels.map { "\($0) Мп" } ?? "мегапікселі не вказані"
        return "\(brand) \(modelText), \(megapixelsText), \(type.rawValue)"
    }
}

func cameraDescription(camera: Camera) -> String {
    camera.cameraDescription()
}

final class Photographer: Identifiable {
    let id = UUID()
    let name: String
    let camera: Camera?

    init(name: String, camera: Camera?) {
        self.name = name
        self.camera = camera
    }

    func cameraInformation() -> String {
        guard let camera else { return "Камера відсутня" }
        return camera.cameraDescription()
    }
}

struct CameraBag {
    var cameraCount: Int
}

struct ContentView: View {
    private let cameras = [
        Camera(brand: "Canon", model: "EOS R6", megapixels: 24.2, type: .mirrorless),
        Camera(brand: "Nikon", model: nil, megapixels: 45.7, type: .DSLR),
        Camera(brand: "Sony", model: "RX100", megapixels: nil, type: .compact)
    ]

    private var photographers: [Photographer] {
        [
            Photographer(name: "Олена", camera: cameras[0]),
            Photographer(name: "Ігор", camera: nil)
        ]
    }

    //ініціалізуємо структуру та її копію
    private let originalBag = CameraBag(cameraCount: 2)
    private var copiedBag: CameraBag {
        var copy = originalBag
        copy.cameraCount = 3
        return copy
    }

    var body: some View {
        List {
            Section("Камери") {
                ForEach(cameras) { camera in
                    Text(cameraDescription(camera: camera))
                }
            }

            Section("Фотографи") {
                ForEach(photographers) { photographer in
                    Text("\(photographer.name): \(photographer.cameraInformation())")
                }
            }

            Section("Структура") {
                Text("Оригінал: \(originalBag.cameraCount) камери")
                Text("Копія: \(copiedBag.cameraCount) камери")
            }
        }
        .navigationTitle("Варіант 6")
    }
}

#Preview {
    NavigationStack { ContentView() }
}
