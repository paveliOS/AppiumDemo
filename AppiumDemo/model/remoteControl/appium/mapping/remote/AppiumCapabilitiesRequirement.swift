final class AppiumCapabilitiesRequirement: Encodable {
    
    let alwaysMatch: AppiumCapabilities // The desired capabilities that the remote end must match
    let firstMatch: [AppiumCapabilities] // List of capabilities that the remote end tries to match. Matches the first in the list
    
    init(alwaysMatch: AppiumCapabilities, firstMatch: [AppiumCapabilities]) {
        self.alwaysMatch = alwaysMatch
        self.firstMatch = firstMatch
    }
}
