# initial setup
flowComp = new FlowComponent
flowComp.header = hdr
flowComp.footer = tabBar
flowComp.backgroundColor = '#FFF'
flowComp.showNext(home)
flowComp.scroll.directionLock = true

# scanner setup
scanner = new VideoLayer
	video: "images/movie.MOV"
	backgroundColor: "black"
	size: Screen.size
scanner.parent = videoContainer
scanner.sendToBack()

# simulate barcode recognition
Events.wrap(scanner.player).on "ended", ->
	scannerTarget_1.stroke = "green"
	scanner.opacity = 0.8
	Utils.delay 1, ->
		flowComp.showOverlayTop(scannerResults)

# click handler transition for tab bar
Scale = () ->
	transition =
		layerA:
			show:
				x: 0
				y: 0
			hide:
				x: 0
				y: 668
				options:
					time:.2
					curve: Spring(damping: .5)
		layerB:
			show:
				x: 0
				y: 0
				options:
					time:.2
					curve: Spring(damping: .8)
			hide:
				x: 0
				y: 668
			
# states
hdr.states = 
	hide:
		y: -68
	animationOptions:
		time: .3
		curve: Bezier.easeInOut
tabBar.states = 
	hide:
		y: 668
	animationOptions:
		time: .3
		curve: Bezier.easeInOut

# click handlers
profile_btn.onClick ->
	flowComp.transition(profile, Scale)
	
home_btn.onClick ->
	flowComp.transition(home, Scale)
	flowComp.scroll.directionLock = true
	
deals_btn.onClick ->
	flowComp.transition(deals, Scale)

cart_btn.onClick ->
	flowComp.transition(cart, Scale)
		
scan_btn.onClick ->
	scanner.player.play()
	flowComp.showOverlayBottom(videoContainer)
	
Icon.onClick ->
	flowComp.showOverlayLeft(menuOverlay)

menuOverlay.onClick ->
	flowComp.showPrevious()
	
cancel_btn.onClick ->
	flowComp.showPrevious()
	scanner.player.load()

scannerResults.onClick ->
	flowComp.transition(home, Scale)

# header / footer peek-a-boo
flowComp.onScroll ->
	if flowComp.scroll.direction is "down"
		tabBar.animate "hide"
		hdr.animate "hide"
	if flowComp.scroll.direction is "up"
		tabBar.animate "default"
		hdr.animate "default"

# home carousel		
carousel = new PageComponent
	width: 375
	height: 216
	parent: home
	directionLock: true
	scrollVertical: false
	x: 0
	y: 0
	z:100	
	
slide1 = new Layer
	parent: carousel.content
	image: "images/slide1.png"
	size: carousel.size

slide2 = new Layer
	parent: carousel.content
	image: "images/slide2.png"
	size: carousel.size

slide3 = new Layer
	parent: carousel.content
	image: "images/slide3.png"
	size: carousel.size
	
carousel.addPage(slide2, "right")
carousel.addPage(slide3, "right")

