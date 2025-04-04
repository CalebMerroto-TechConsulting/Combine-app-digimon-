//
//  IndividualDigimonView.swift
//  digimon app
//
//  Created by Caleb Merroto on 3/6/25.
//
import SwiftUI

struct IndividualDigimonView: UIViewRepresentable {
    @EnvironmentObject var screen: ScreenSizeObserver
    @Binding var digi: Digimon
    var isLandscape: Bool { screen.width < screen.height }
    var imageSize: CGFloat { isLandscape ? screen.width * 0.6 : screen.height * 0.6 }
     
    func makeUIView(context: Context) -> UIView {
        
        // declare components
        let containerView = UIView()
        let swiftUIView = UIHostingController(
            rootView: DigimonImage(
                    digimon: digi,
                    size: imageSize,
                    shadowColor: digi.evo
                )
            ).view!
        let nameLabel = UILabel()
        let levelLabel = UILabel()
        
        // disable auto constraints for all components
        containerView.translatesAutoresizingMaskIntoConstraints = false
        swiftUIView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        // Text styling
        nameLabel.font = UIFont.boldSystemFont(ofSize: imageSize * 0.25)

        levelLabel.font = UIFont.systemFont(ofSize: imageSize * 0.13)
        levelLabel.textColor = .darkGray

        // add subviews
        containerView.addSubview(swiftUIView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(levelLabel)

        // define layout
        NSLayoutConstraint.activate([
            // Image scales dynamically with screen size
            swiftUIView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: isLandscape ? screen.width * 0.5 : screen.width * 0.25),
            swiftUIView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: screen.width * 0.1),
            swiftUIView.widthAnchor.constraint(equalToConstant: imageSize),
            swiftUIView.heightAnchor.constraint(equalToConstant: imageSize),

            // Name label below image
            nameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: isLandscape ? screen.width * 0.5 : screen.width * 0.6),
            nameLabel.topAnchor.constraint(equalTo: isLandscape ? swiftUIView.bottomAnchor : swiftUIView.topAnchor, constant: screen.width * 0.07),

            // Level label below name
            levelLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: isLandscape ? screen.width * 0.5 : screen.width * 0.6),
            levelLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: screen.width * 0.03),
            levelLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -screen.width * 0.1)
        ])

        return containerView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        guard let nameLabel = uiView.subviews[1] as? UILabel,
              let levelLabel = uiView.subviews[2] as? UILabel else { return }

        nameLabel.text = digi.name
        levelLabel.text = digi.level
        levelLabel.textColor = UIColor(digi.evo)
    }
}

#Preview {
    IndividualDigimonView(
        digi: .constant(
            Digimon(
                name: "Koromon",
                level: "In Training",
                img: "https://digimon.shadowsmith.com/img/koromon.jpg"
            )
        )
    ).environmentObject(ScreenSizeObserver())
}
