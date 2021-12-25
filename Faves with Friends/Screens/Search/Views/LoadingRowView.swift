//
//  LoadingRowView.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 12/25/21.
//

import SwiftUI


struct LoadingRowView: View {
	
    var body: some View {
		ProgressView()
			.tint(.black)
			.scaleEffect(1.5)
			.ignoresSafeArea()
			.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct LoadingRowView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingRowView()
    }
}
