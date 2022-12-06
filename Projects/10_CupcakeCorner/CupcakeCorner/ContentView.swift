//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Tom LEBRUN on 12/10/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var orderWrapper = OrderWrapper(order: Order())

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $orderWrapper.order.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }

                    Stepper("Number of cakes: \(orderWrapper.order.quantity)", value: $orderWrapper.order.quantity, in: 3...20)
                    
                    Section {
                        Toggle("Any special requests?", isOn: $orderWrapper.order.specialRequestEnabled.animation())

                        if orderWrapper.order.specialRequestEnabled {
                            Toggle("Add extra frosting", isOn: $orderWrapper.order.extraFrosting)

                            Toggle("Add extra sprinkles", isOn: $orderWrapper.order.addSprinkles)
                        }
                    }
                    
                    Section {
                        NavigationLink {
                            AdressView(orderWrapper: OrderWrapper(order: orderWrapper.order))
                        } label: {
                            Text("Delivery details")
                        }
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
