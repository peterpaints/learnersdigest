/* eslint-env browser */

window.onload = () => {
  const vis = window.vis;

  const nodes = new vis.DataSet([
    { label: 'Python' },
    { label: 'JavaScript' },
    { label: 'CSS' },
    { label: 'HTML' },
    { label: 'C#' },
    { label: 'Java' },
    { label: 'C++' },
    { label: 'Design' },
    { label: 'Ruby' },
    { label: 'Ruby on Rails' },
  ]);

  const edges = new vis.DataSet();
  const container = document.getElementById('bubbles');

  console.log('Container: ', container);

  const data = {
    nodes,
    edges,
  };
  const options = {
    nodes: {
      borderWidth: 0,
      shape: 'circle',
      color: {
        background: '#F92C55',
        highlight: {
          background: '#F92C55',
          border: '#F92C55',
        },
      },
      font: {
        color: '#fff',
      },
    },
    physics: {
      stabilization: false,
      minVelocity: 0.01,
      solver: 'repulsion',
      repulsion: {
        nodeDistance: 40,
      },
    },
  };
  const network = new vis.Network(container, data, options);


  // Events
  network.on('click', (e) => {
    if (e.nodes.length) {
      const node = nodes.get(e.nodes[0]);
      // Do something
      nodes.update(node);
    }
  });
};
