command: "date +%A,%B,%e,%Y,%H:%M,%V"

refreshFrequency: 50000

style: """
  /* Modify Colors and Size Here:*/
  
  size = 800px                //This is just a base for the overall size so everything stays centered

  width: size 
  margin-left: -.5 * size     //Set left edge of widget to be center so it can be easily centered on the page
  text-align: center


  height: 130px             
  margin-top: -.5 * 130px
  vertical-align: middle

  /*POSITION*/
  // top: 50%
  // left: 50% 

  top: 280px
  left: 400px

  /*COLORS*/
  primaryColor = rgba(255,255,255,0.75)
  secondaryColor = rgba(255,255,255,0.55)


  font-family: Helvetica Neue
  font-weight: 400
  font-size: 46px

  #main
    color: primaryColor
    font-size: 72px

  #suffix
  	color: primaryColor
  	font-weight: 200
  	margin-left: -15px         //Forces suffix to be closer to numDate

  #secondary
    //font-weight: 100
  	color: secondaryColor

  #clock
    color: primaryColor
    font-size: 72px
"""


render: (output) -> """
  <div>
    <span id ="main"></span>    <!--Primary date info (Day of week, numDate)-->
    <sup id="suffix"></sup>     <!--Suffix for numDate-->
  </div>
  <div id="secondary"></div>    <!--Additional date info (month, year)-->
  <div id="clock"></div>

"""


update: (output) ->
  dateInfo = output.split(',')

  day = dateInfo[0]
  month = dateInfo[1]
  numDate = parseInt(dateInfo[2])
  year = dateInfo[3]
  time = dateInfo[4]
  weeknum = dateInfo[5]

  secondDigit = numDate%10

  # This switch determines the appropriate suffix for the numDate:
  suffix = switch
  	when numDate is 1 then 'st'
  	when numDate is 2 then 'nd'
  	when numDate is 3 then 'rd'
  	when numDate < 21 then 'th'
  	when numDate is 21 then 'st'
  	when numDate is 22 then 'nd'
  	when numDate is 23 then 'rd'
  	when numDate < 31 then 'th'
  	when numDate is 31 then 'st'
  	else 'ERROR'

  top = day+" the "+numDate
  bottom = month+" "+year + ", week " + weeknum

  $('#main').text top           #Add day and numDate to main
  $('#suffix').text suffix      #Add suffix to numDate
  $('#secondary').text bottom   #Add month and year to secondary
  $('#clock').text time         #Add time

