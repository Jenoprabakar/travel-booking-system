<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>
  
  <xsl:template match="/">
    <html>
      <head>
        <title>Travel Booking Confirmation</title>
        <style>
          body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
          }
          .header {
            background-color: #3a86ff;
            color: white;
            padding: 20px;
            text-align: center;
            border-radius: 5px 5px 0 0;
          }
          .booking-details {
            border: 1px solid #ddd;
            border-radius: 0 0 5px 5px;
            padding: 20px;
            margin-bottom: 20px;
          }
          .section {
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
          }
          .trip {
            background-color: #f9f9f9;
            border-left: 4px solid #3a86ff;
            padding: 15px;
            margin-bottom: 15px;
          }
          .flight { border-left-color: #3a86ff; }
          .hotel { border-left-color: #8338ec; }
          .car { border-left-color: #ff006e; }
          .payment {
            background-color: #f0f0f0;
            padding: 15px;
            border-radius: 5px;
          }
          .status-confirmed { color: green; }
          .status-pending { color: orange; }
          .status-cancelled { color: red; }
        </style>
      </head>
      <body>
        <div class="header">
          <h1>Travel Booking Confirmation</h1>
        </div>
        
        <xsl:apply-templates select="/TravelBookingSystem/Booking"/>
        
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="Booking">
    <div class="booking-details">
      <h2>
        Booking ID: <xsl:value-of select="@id"/>
        <span class="status-{@status}"> (<xsl:value-of select="@status"/>)</span>
      </h2>
      
      <div class="section">
        <h3>Customer Information</h3>
        <p><strong>Name:</strong> <xsl:value-of select="Customer/Name"/></p>
        <p><strong>Email:</strong> <xsl:value-of select="Customer/Email"/></p>
        <p><strong>Phone:</strong> <xsl:value-of select="Customer/Phone"/></p>
      </div>
      
      <div class="section">
        <h3>Itinerary</h3>
        <xsl:apply-templates select="Itinerary/Trip"/>
      </div>
      
      <div class="section payment">
        <h3>Payment Details</h3>
        <p><strong>Method:</strong> <xsl:value-of select="Payment/Method"/></p>
        <p><strong>Total Amount:</strong> <xsl:value-of select="Payment/Currency"/> <xsl:value-of select="Payment/TotalAmount"/></p>
        <xsl:if test="Payment/Details">
          <p><strong>Card Type:</strong> <xsl:value-of select="Payment/Details/CardType"/></p>
          <p><strong>Card Number:</strong> **** **** **** <xsl:value-of select="Payment/Details/LastFourDigits"/></p>
        </xsl:if>
      </div>
    </div>
  </xsl:template>
  
  <xsl:template match="Trip[@type='flight']">
    <div class="trip flight">
      <h4>Flight: <xsl:value-of select="FlightNumber"/></h4>
      <p><strong>Airline:</strong> <xsl:value-of select="Carrier"/></p>
      <p><strong>Class:</strong> <xsl:value-of select="Class"/></p>
      <p>
        <strong>Departure:</strong> 
        <xsl:value-of select="Departure/Location"/>
        (<xsl:value-of select="Departure/Location/@code"/>)
        on <xsl:value-of select="substring(Departure/DateTime, 1, 10)"/>
        at <xsl:value-of select="substring(Departure/DateTime, 12, 5)"/>
      </p>
      <p>
        <strong>Arrival:</strong>
        <xsl:value-of select="Arrival/Location"/>
        (<xsl:value-of select="Arrival/Location/@code"/>)
        on <xsl:value-of select="substring(Arrival/DateTime, 1, 10)"/>
        at <xsl:value-of select="substring(Arrival/DateTime, 12, 5)"/>
      </p>
    </div>
  </xsl:template>
  
  <xsl:template match="Trip[@type='hotel']">
    <div class="trip hotel">
      <h4>Hotel: <xsl:value-of select="Property/Name"/></h4>
      <p><strong>Check-in:</strong> <xsl:value-of select="CheckIn"/></p>
      <p><strong>Check-out:</strong> <xsl:value-of select="CheckOut"/></p>
      <p>
        <strong>Address:</strong>
        <xsl:value-of select="Property/Address/Street"/>,
        <xsl:value-of select="Property/Address/City"/>,
        <xsl:value-of select="Property/Address/PostalCode"/>,
        <xsl:value-of select="Property/Address/Country"/>
      </p>
      <p><strong>Room Type:</strong> <xsl:value-of select="Room/@type"/></p>
      <p><strong>Bed Type:</strong> <xsl:value-of select="Room/BedType"/></p>
      <p><strong>Guests:</strong> <xsl:value-of select="Room/Guests"/></p>
      <p><strong>Rating:</strong> <xsl:value-of select="Property/Rating"/> stars</p>
    </div>
  </xsl:template>
  
  <xsl:template match="Trip[@type='car']">
    <div class="trip car">
      <h4>Car Rental: <xsl:value-of select="Vehicle/Make"/> <xsl:value-of select="Vehicle/Model"/></h4>
      <p><strong>Vehicle Type:</strong> <xsl:value-of select="Vehicle/Type"/></p>
      <p>
        <strong>Pick-up:</strong>
        <xsl:value-of select="PickUp/Location"/>
        on <xsl:value-of select="substring(PickUp/DateTime, 1, 10)"/>
        at <xsl:value-of select="substring(PickUp/DateTime, 12, 5)"/>
      </p>
      <p>
        <strong>Drop-off:</strong>
        <xsl:value-of select="DropOff/Location"/>
        on <xsl:value-of select="substring(DropOff/DateTime, 1, 10)"/>
        at <xsl:value-of select="substring(DropOff/DateTime, 12, 5)"/>
      </p>
    </div>
  </xsl:template>
  
</xsl:stylesheet>