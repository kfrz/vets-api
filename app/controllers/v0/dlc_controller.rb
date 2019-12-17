# frozen_string_literal: true

# example controller to show use of logging in with sessions controller

module V0
  class DlcController < ApplicationController
    before_action :authenticate, only: [:welcome]

    ParticipandID = 123
    ProductGroup = ''

    def DlcOrderStatus(participandID,productGroup = nil)
        s = '{"data":{"atrributes":[{"DateProcessed":"43711","Recipient":"1014","Age":"81","Product":"ZA13MF","ProductGroup":"BATTERIES","DelToState":"VA","Order_Intake_Method":"AUTOMATED PHONE SYSTEM"},{"DateProcessed":"43711","Recipient":"1014","Age":"89","Product":"ZA13MF","ProductGroup":"BATTERIES","DelToState":"VA","Order_Intake_Method":"PHONE"},{"DateProcessed":"43711","Recipient":"1014","Age":"71","Product":"ZA312MF","ProductGroup":"BATTERIES","DelToState":"VA","Order_Intake_Method":"E-MAIL"},{"DateProcessed":"43711","Recipient":"1014","Age":"70","Product":"ZA312MF","ProductGroup":"BATTERIES","DelToState":"VA","Order_Intake_Method":"PHONE"},{"DateProcessed":"43711","Recipient":"1010","Age":"84","Product":"ZA312MF","ProductGroup":"BATTERIES","DelToState":"OH","Order_Intake_Method":"AUTOMATED PHONE SYSTEM"},{"DateProcessed":"43712","Recipient":"1010","Age":"71","Product":"ALKAAA","ProductGroup":"BATTERIES","DelToState":"CA","Order_Intake_Method":"AUTOMATED PHONE SYSTEM"},{"DateProcessed":"43712","Recipient":"1010","Age":"71","Product":"ZA312MF","ProductGroup":"BATTERIES","DelToState":"CA","Order_Intake_Method":"AUTOMATED PHONE SYSTEM"},{"DateProcessed":"43712","Recipient":"1010","Age":"73","Product":"ZA312MF","ProductGroup":"BATTERIES","DelToState":"NC","Order_Intake_Method":"AUTOMATED PHONE SYSTEM"},{"DateProcessed":"43713","Recipient":"1014","Age":"78","Product":"ZA13MF","ProductGroup":"BATTERIES","DelToState":"VA","Order_Intake_Method":"CARD"},{"DateProcessed":"43713","Recipient":"1014","Age":"70","Product":"ZA13MF","ProductGroup":"BATTERIES","DelToState":"VA","Order_Intake_Method":"CARD"},{"DateProcessed":"43713","Recipient":"1010","Age":"72","Product":"ZA312MF","ProductGroup":"BATTERIES","DelToState":"WA","Order_Intake_Method":"CARD"},{"DateProcessed":"43713","Recipient":"1017","Age":"70","Product":"ZA13MF","ProductGroup":"BATTERIES","DelToState":"NJ","Order_Intake_Method":"AUTOMATED PHONE SYSTEM"},{"DateProcessed":"43714","Recipient":"1010","Age":"84","Product":"ZA312MF","ProductGroup":"BATTERIES","DelToState":"WY","Order_Intake_Method":"CARD"},{"DateProcessed":"43714","Recipient":"1017","Age":"73","Product":"ZA10MF","ProductGroup":"BATTERIES","DelToState":"CA","Order_Intake_Method":"CARD"},{"DateProcessed":"43714","Recipient":"1010","Age":"81","Product":"ZA13MF","ProductGroup":"BATTERIES","DelToState":"NV","Order_Intake_Method":"CARD"},{"DateProcessed":"43714","Recipient":"1010","Age":"93","Product":"ZA13MF","ProductGroup":"BATTERIES","DelToState":"CA","Order_Intake_Method":"CARD"},{"DateProcessed":"43714","Recipient":"1017","Age":"77","Product":"ZA13MF","ProductGroup":"BATTERIES","DelToState":"CA","Order_Intake_Method":"PHONE"},{"DateProcessed":"43714","Recipient":"1010","Age":"95","Product":"ZA13MF","ProductGroup":"BATTERIES","DelToState":"FL","Order_Intake_Method":"PHONE"},{"DateProcessed":"43717","Recipient":"1017","Age":"70","Product":"ZA13MF","ProductGroup":"BATTERIES","DelToState":"IN","Order_Intake_Method":"CARD"},{"DateProcessed":"43717","Recipient":"1010","Age":"70","Product":"ZA312MF","ProductGroup":"BATTERIES","DelToState":"IN","Order_Intake_Method":"CARD"},{"DateProcessed":"43717","Recipient":"1017","Age":"86","Product":"ZA312MF","ProductGroup":"BATTERIES","DelToState":"IL","Order_Intake_Method":"PHONE"},{"DateProcessed":"43717","Recipient":"1010","Age":"85","Product":"ZA13MF","ProductGroup":"BATTERIES","DelToState":"MO","Order_Intake_Method":"CARD"},{"DateProcessed":"43735","Recipient":"1017","Age":"71","Product":"ZA13MF","ProductGroup":"BATTERIES","DelToState":"AL","Order_Intake_Method":"E-MAIL"},{"DateProcessed":"43713","Recipient":"1014","Age":"70","Product":"MINI RECEIVER WAX GUARD KIT","ProductGroup":"ACCESSORIES","DelToState":"OK","Order_Intake_Method":"CARD"},{"DateProcessed":"43713","Recipient":"1010","Age":"70","Product":"MINI RECEIVER WAX GUARD KIT","ProductGroup":"ACCESSORIES","DelToState":"OK","Order_Intake_Method":"CARD"},{"DateProcessed":"43713","Recipient":"1014","Age":"70","Product":"CLICK DOMES SEMI-OPEN 8/12MM","ProductGroup":"ACCESSORIES","DelToState":"OK","Order_Intake_Method":"CARD"},{"DateProcessed":"43713","Recipient":"1010","Age":"81","Product":"MF BASS DOUBLE DOME 8MM","ProductGroup":"ACCESSORIES","DelToState":"TN","Order_Intake_Method":"PHONE"},{"DateProcessed":"43713","Recipient":"1014","Age":"81","Product":"PROWAX FOR MF","ProductGroup":"ACCESSORIES","DelToState":"TN","Order_Intake_Method":"PHONE"},{"DateProcessed":"43713","Recipient":"1017","Age":"73","Product":"CERUSHIELD DISK","ProductGroup":"ACCESSORIES","DelToState":"OK","Order_Intake_Method":"CARD"},{"DateProcessed":"43713","Recipient":"1017","Age":"73","Product":"MEDIUM OPEN DOME","ProductGroup":"ACCESSORIES","DelToState":"OK","Order_Intake_Method":"CARD"},{"DateProcessed":"43713","Recipient":"1010","Age":"73","Product":"MEDIUM VENTED DOME","ProductGroup":"ACCESSORIES","DelToState":"OK","Order_Intake_Method":"CARD"},{"DateProcessed":"43713","Recipient":"1017","Age":"70","Product":"CLICK DOMES CLOSED 10MM","ProductGroup":"ACCESSORIES","DelToState":"LA","Order_Intake_Method":"CARD"},{"DateProcessed":"43713","Recipient":"1014","Age":"71","Product":"CERUSTOP 8 PIECES","ProductGroup":"ACCESSORIES","DelToState":"CA","Order_Intake_Method":"CARD"},{"DateProcessed":"43713","Recipient":"1017","Age":"71","Product":"CLEANING TOOL 2014","ProductGroup":"ACCESSORIES","DelToState":"CA","Order_Intake_Method":"CARD"},{"DateProcessed":"43713","Recipient":"1010","Age":"71","Product":"PROWAX-SYSTEM","ProductGroup":"ACCESSORIES","DelToState":"CO","Order_Intake_Method":"CARD"},{"DateProcessed":"43714","Recipient":"1017","Age":"87","Product":"DRY AID KIT","ProductGroup":"ACCESSORIES","DelToState":"NV","Order_Intake_Method":"CARD"},{"DateProcessed":"43717","Recipient":"1010","Age":"85","Product":"CERUSTOP 8 PIECES","ProductGroup":"ACCESSORIES","DelToState":"MA","Order_Intake_Method":"PHONE"},{"DateProcessed":"43717","Recipient":"1017","Age":"74","Product":"CERUSTOP 8 PIECES","ProductGroup":"ACCESSORIES","DelToState":"VA","Order_Intake_Method":"PHONE"},{"DateProcessed":"43717","Recipient":"1014","Age":"74","Product":"SMOKEY DOME CLOSED M 9","ProductGroup":"ACCESSORIES","DelToState":"VA","Order_Intake_Method":"PHONE"},{"DateProcessed":"43717","Recipient":"1010","Age":"75","Product":"CERUSTOP 8 PIECES","ProductGroup":"ACCESSORIES","DelToState":"FL","Order_Intake_Method":"CARD"},{"DateProcessed":"43718","Recipient":"1017","Age":"71","Product":"SMOKEY DOME POWER M 9","ProductGroup":"ACCESSORIES","DelToState":"FL","Order_Intake_Method":"PHONE"},{"DateProcessed":"43718","Recipient":"1010","Age":"71","Product":"SLIMTUBE HE 2 L S SET ","ProductGroup":"ACCESSORIES","DelToState":"FL","Order_Intake_Method":"CARD"},{"DateProcessed":"43718","Recipient":"1017","Age":"71","Product":"SLIMTUBE HE 2 R S SET ","ProductGroup":"ACCESSORIES","DelToState":"FL","Order_Intake_Method":"CARD"},{"DateProcessed":"43718","Recipient":"1014","Age":"71","Product":"SMOKEY DOME POWER S 7.5","ProductGroup":"ACCESSORIES","DelToState":"VA","Order_Intake_Method":"CARD"},{"DateProcessed":"43718","Recipient":"1010","Age":"84","Product":"WAXGUARD CERUSTOP","ProductGroup":"ACCESSORIES","DelToState":"KS","Order_Intake_Method":"PHONE"},{"DateProcessed":"43718","Recipient":"1017","Age":"62","Product":"HEAR CLEAR 8 PK","ProductGroup":"ACCESSORIES","DelToState":"CO","Order_Intake_Method":"E-MAIL"},{"DateProcessed":"43718","Recipient":"1010","Age":"71","Product":"WAXGUARD CERUSTOP","ProductGroup":"ACCESSORIES","DelToState":"AL","Order_Intake_Method":"PHONE"},{"DateProcessed":"43713","Recipient":"1014","Age":"72","Product":"TSHIRT-C-XXLG-VCUT-WHT-TALL","ProductGroup":"PROSTHETIC SOCKS","DelToState":"VA","Order_Intake_Method":"PHONE"},{"DateProcessed":"43713","Recipient":"1010","Age":"72","Product":"TSHIRT-C-XXLG-CREW-WHT-TALL","ProductGroup":"PROSTHETIC SOCKS","DelToState":"IL","Order_Intake_Method":"PHONE"},{"DateProcessed":"43713","Recipient":"1014","Age":"119","Product":"CML-LTWT-NRW-SHORT-SUS-KR","ProductGroup":"PROSTHETIC SOCKS","DelToState":"VA","Order_Intake_Method":"E-MAIL"},{"DateProcessed":"43713","Recipient":"1010","Age":"119","Product":"CML-1-NRW-SHORT-SUS-ROY","ProductGroup":"PROSTHETIC SOCKS","DelToState":"NC","Order_Intake_Method":"CARD"},{"DateProcessed":"43714","Recipient":"1017","Age":"72","Product":"TSHIRT-C-XXLG-VCUT-WHT-TALL","ProductGroup":"PROSTHETIC SOCKS","DelToState":"IL","Order_Intake_Method":"UNKNOWN"},{"DateProcessed":"43714","Recipient":"1010","Age":"72","Product":"TSHIRT-C-XXLG-CREW-WHT-TALL","ProductGroup":"PROSTHETIC SOCKS","DelToState":"IL","Order_Intake_Method":"UNKNOWN"},{"DateProcessed":"43718","Recipient":"1014","Age":"77","Product":"CM-5-1/2-16/18-ROY","ProductGroup":"PROSTHETIC SOCKS","DelToState":"VA","Order_Intake_Method":"CARD"},{"DateProcessed":"43720","Recipient":"1010","Age":"72","Product":"TSHIRT-C-XXLG-VCUT-WHT-TALL","ProductGroup":"PROSTHETIC SOCKS","DelToState":"IL","Order_Intake_Method":"UNKNOWN"},{"DateProcessed":"43720","Recipient":"1010","Age":"72","Product":"TSHIRT-C-XXLG-CREW-WHT-TALL","ProductGroup":"PROSTHETIC SOCKS","DelToState":"IL","Order_Intake_Method":"UNKNOWN"},{"DateProcessed":"43720","Recipient":"1014","Age":"73","Product":"WX-5-MED-SHORT-KR","ProductGroup":"PROSTHETIC SOCKS","DelToState":"VA","Order_Intake_Method":"CARD"},{"DateProcessed":"43721","Recipient":"1010","Age":"139","Product":"OL-5-MED-REG-COM","ProductGroup":"PROSTHETIC SOCKS","DelToState":"FL","Order_Intake_Method":"CARD"},{"DateProcessed":"43724","Recipient":"1017","Age":"82","Product":"SHEATH-DAW-1300-F3-35-YLW-DAW","ProductGroup":"PROSTHETIC SOCKS","DelToState":"NY","Order_Intake_Method":"E-MAIL"},{"DateProcessed":"43724","Recipient":"1010","Age":"82","Product":"SHEATH-DAW-1300-F3-35-YLW-DAW","ProductGroup":"PROSTHETIC SOCKS","DelToState":"NY","Order_Intake_Method":"UNKNOWN"},{"DateProcessed":"43724","Recipient":"1014","Age":"82","Product":"W-3-1-10-UNH-STR-KR","ProductGroup":"PROSTHETIC SOCKS","DelToState":"VA","Order_Intake_Method":"E-MAIL"},{"DateProcessed":"43724","Recipient":"1010","Age":"82","Product":"W-5-1-10-UNH-STR-KR","ProductGroup":"PROSTHETIC SOCKS","DelToState":"NY","Order_Intake_Method":"E-MAIL"},{"DateProcessed":"43726","Recipient":"1014","Age":"69","Product":"WX-6-WIDE-LONG-KR","ProductGroup":"PROSTHETIC SOCKS","DelToState":"VA","Order_Intake_Method":"CARD"},{"DateProcessed":"43726","Recipient":"1010","Age":"69","Product":"WX-6-WIDE-LONG-KR","ProductGroup":"PROSTHETIC SOCKS","DelToState":"MN","Order_Intake_Method":"CARD"}]}}'
        h = JSON.parse(s)

        #ACCESSORIES
        #PROSTHETIC SOCKS
        #BATTERIES
       if(productGroup != nil)
        case productGroup
        when '1'
          productGroup = 'BATTERIES'
        when '2'
          productGroup = 'PROSTHETIC SOCKS'
        when '3'
          productGroup = 'ACCESSORIES'
        else
          productGroup = nil
        end
      end

      if(productGroup != nil)
          h = h["data"]["atrributes"].select {|h1| h1['Recipient']== participandID && h1['ProductGroup']== productGroup }
       else
          h = h["data"]["atrributes"].select {|h1| h1['Recipient']== participandID}
       end
        h = "{\"data\":{\"atrributes\":" + h.to_json + "}}"
        render json: h
        #render participandID
    end

    

    def OrderStatus
      #ACCESSORIES
      #PROSTHETIC SOCKS
      #BATTERIES 
      #render json: '{"data":{"atrributes":[{"Recipient":"' + params[:id] + '","Recipient":"' + params[:product] + '"}]}}'
       DlcOrderStatus(params[:id])
      end

      def OrderStatusByProduct
      
        DlcOrderStatus(params[:id], params[:product])
          #render params[:OrderType]
        end

       

    def limited
      render json: { "message": 'Rate limited action' }
    end

    def welcome
      msg = "You are logged in as #{@current_user.email}"
      render json: { "message": msg }
    end
  end
end