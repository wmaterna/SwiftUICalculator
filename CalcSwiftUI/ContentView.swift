//
//  ContentView.swift
//  CalcSwiftUI
//
//  Created by Weronika Materna on 12/12/2020.
//  Copyright © 2020 Weronika Materna. All rights reserved.
//

import SwiftUI


struct ContentView: View {
	
	let buttonsList = [
		["7", "8", "9", "+"],
		["4", "5", "6", "-"],
		["1", "2", "3", "*"],
		["0", "=", "C", "÷"]]
	
	@State var finalValue:String = "6"
	@State var expression: [String] = []
	@State var finishedTypingNumber: Bool = true
	@State var currentSymbol: String = "+"
	@State var prevNumber: Double = 0.0
	@State var result: Double = 0.0
	
	var body: some View {
		ZStack(alignment:.bottom){
			Color.black.edgesIgnoringSafeArea(.all)
			VStack{
				Text(self.finalValue)
					.font(.system(size:80))
					.foregroundColor(.white)
					.frame(maxWidth: .infinity, alignment: .trailing)
					.padding()
				
				ForEach(buttonsList, id:\.self){ row in
					HStack(alignment:.bottom){
						ForEach(row, id:\.self) { column in
							Button(action: {
								if column == "C"{
									self.finalValue = ""
								}
								
								else if !checkIfOperator(str: column) && column != "=" {
									if self.finishedTypingNumber{
										self.finalValue = column
										self.finishedTypingNumber = false
									} else {
										self.finalValue = self.finalValue + column
									}
									
								}
								else if checkIfOperator(str: column){
									if self.finalValue != ""{
									self.prevNumber = Double(self.finalValue) as! Double
									print(self.prevNumber)
									self.currentSymbol = column
									self.finishedTypingNumber = true
									} else{
										print("Operation pressed without any number")
									}
								}
								else if column == "="{
									var result: Double = 0.0
									if self.finalValue != ""{
										switch self.currentSymbol{
										case "+":
											self.result = Double(self.prevNumber) + Double(Int(self.finalValue)!)
										case "-":
											print(self.finalValue)
											self.result = Double(self.prevNumber) - Double(self.finalValue)!
										case "*":
											self.result = Double(self.prevNumber) * Double(self.finalValue)!
										case "÷":
											self.result = Double(self.prevNumber) / Double(self.finalValue)!
										default:
											print("Unknown action")
										}
										self.finalValue = String(self.result)
										self.finishedTypingNumber = true
										
									} else {
										print("equal sign was pressed without any number ")
										return
									}
								}
	
							}, label:{
								Text(column)
									.frame(width: 80, height: 80)
									.foregroundColor(.white)
									.font(.system(size:40))
									.background(Color.yellow)
									.cornerRadius(50)
							})
						}
					}.padding(.bottom)
				}
			}.padding()
			
		}
	}
	
}


func checkIfOperator(str:String) -> Bool {
	
	if str == "÷" || str == "*" || str == "-" || str == "+" {
		return true
	}
	
	return false
	
}


struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}

