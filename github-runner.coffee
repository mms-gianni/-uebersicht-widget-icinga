config =
  title: 'Runners'
  token: 'CHANGEME'
  org: 'CHANGEME'
  topposition: '650px'
  leftposition: '10px'

command: "curl -sS -u :#{config.token}  -H \"Accept: application/vnd.github.v3+json\" https://api.github.com/orgs/#{config.org}/actions/runners"

refreshFrequency: 4800

style: """	
  color: #fff
  font-family: Helvetica Neue
  background: rgba(#fff, .3)
  padding 10px 15px 0px
  border-radius: 5px
  font-size: 11px


  /*bottom: #{config.topposition}*/
  top: #{config.topposition}
  left: #{config.leftposition}

  #header
    width: 100%
    text-transform: uppercase
    font-size: 10px
    font-weight: bold
    padding-bottom: 8px

  #list
    float: right

  .status 
    float: right
    margin: 10px

  .runner
    vertical-align: middle

  .online
    top: 50%
    left: 50%
    height: 16px
    width: 16px
    border: 4px rgba(#FFF, 0.25) solid
    border-top: 4px #6A0 solid
    border-bottom: 4px #6A0 solid
    border-radius: 50%
    margin: -8px -4px 0 -8px
    -webkit-animation: spin1 1s infinite linear
    animation: spin1 1s infinite linear

  @-webkit-keyframes spin1
    from
      -webkit-transform: rotate(0deg)
      transform: rotate(0deg)
    to
      -webkit-transform: rotate(359deg)
      transform: rotate(359deg)

  @keyframes spin1
    from
      -webkit-transform: rotate(0deg)
      transform: rotate(0deg)
      -webkit-transform: rotate(0deg)
      transform: rotate(0deg)
    to
      -webkit-transform: rotate(359deg)
      transform: rotate(359deg)
      -webkit-transform: rotate(359deg)
      transform: rotate(359deg)

  .online-idle
    top: 50%
    left: 50%
    height: 16px
    width: 16px
    margin: -8px -4px 0 -8px
    /*margin: -25px 0 0 -25px*/
    border: 4px rgba(#6A0, 1) solid
    border-radius: 50%

  .offline
    top: 50%
    left: 50%
    height: 16px
    width: 16px
    margin: -8px -4px 0 -8px
    /*margin: -25px 0 0 -25px*/
    border: 4px rgba(#000, 1) solid
    border-radius: 50%
  
"""

render: -> """
  <div id="header">#{config.title}</div>
  <div>
    <div id="list">
  </div>
"""

update: (output, domEl) ->
  runners = JSON.parse(output)
  table  = $(domEl).find('#list')

  # Reset the table
  table.html('')

  
  renderBuild = (runner) ->
    """
        <div class="status">
          <div class="#{ runner.displaystatus }"></div>
          <!--<span class="runner">#{ runner.name }</span>-->
        </div>
    """

  for runner in runners['runners']

    if runner.status == 'online'
      runner.displaystatus = 'online'
      if runner.busy == false
        runner.displaystatus = 'online-idle'
    else
      runner.displaystatus = 'offline'

    table.append renderBuild(runner)
