
import ProjectDescription

let project = Project(
    name: "PWrapperShow",
    targets: [
        .target(
            name: "PWrapperShow",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.tuist.PWrapperShow",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["PWrapperShow/sources/**"],
            resources: ["PWrapperShow/resources/**"],
            dependencies: [
                .external(name: "HotSwiftUI"),
            ],
            settings: .settings(
                base: [
                    "OTHER_LDFLAGS": [
                        "$(inherited)", // Always include this to preserve default linker flags
                        "-Xlinker", // Passes the next argument directly to the linker
                        "-interposable", // The actual linker flag for HotSwiftUI
                    ],
                    // User defined build setting for HotSwiftUI
                    "EMIT_FRONTEND_COMMAND_LINES": "YES",
                ]
            )
        ),
        .target(
            name: "PWrapperShowTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.tuist.PWrapperShowTests",
            infoPlist: .default,
            sources: ["PWrapperShow/Tests/**"],
            resources: [],
            dependencies: [.target(name: "PWrapperShow")]
        ),
    ]
)
