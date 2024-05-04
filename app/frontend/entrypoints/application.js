// To see this message, add the following to the `<head>` section in your
// views/layouts/application.html.erb
//
//    <%= vite_client_tag %>
//    <%= vite_javascript_tag 'application' %>
console.log('Vite ⚡️ Rails')

// If using a TypeScript entrypoint file:
//     <%= vite_typescript_tag 'application' %>
//
// If you want to use .jsx or .tsx, add the extension:
//     <%= vite_javascript_tag 'application.jsx' %>

console.log('Visit the guide for more information: ', 'https://vite-ruby.netlify.app/guide/rails')

// Example: Load Rails libraries in Vite.
//
// import * as Turbo from '@hotwired/turbo'
// Turbo.start()
//
// import ActiveStorage from '@rails/activestorage'
// ActiveStorage.start()
//
// // Import all channels.
// const channels = import.meta.globEager('./**/*_channel.js')

// Example: Import a stylesheet in app/frontend/index.css
import './application.scss'
import "../../../node_modules/bootstrap/dist/js/bootstrap.bundle.min"
import toast from './toast'

window.toast = toast;





async function fetchDataAndUpdateContent(event) {
    // Получаем значение атрибута target
    var awardId = event.target.getAttribute("data-award-id");
    var portfolioId = event.target.getAttribute("data-portfolio-id");

    var url = portfolioId ? `http://localhost:3000/awards/new?portfolio_id=${portfolioId}` : `http://localhost:3000/awards/${awardId}/edit`;

    try {
        const response = await fetch(url, { method: "GET" });

        const html = await response.json();

        const element = document.getElementById("my-id");
        element.innerHTML = html["partial"];
        console.log("end");

        var myModal = new bootstrap.Modal(document.getElementById('exampleModal'), {
        keyboard: false
            })
        myModal.show();

    } catch (error) {
        console.error('Ошибка при выполнении запроса:', error);
    }
}


var awardsModals = document.querySelectorAll(".awards-modal");

// Проходим по каждому элементу и добавляем обработчик события
awardsModals.forEach(function(modal) {
    modal.addEventListener("click", fetchDataAndUpdateContent);
});


document.addEventListener('DOMContentLoaded', () => {
    const deleteButtons = document.querySelectorAll('.delete-button');

    deleteButtons.forEach(button => {
        button.addEventListener('click', (event) => {
            const isConfirmed = confirm('Вы уверены?');
            if (!isConfirmed) {
                event.preventDefault();
            }
        });
    });
});
