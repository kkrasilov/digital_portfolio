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
import "../../../node_modules/bootstrap/dist/js/bootstrap.min"
import toast from './toast'
import { Modal } from '../../../node_modules/bootstrap/dist/js/bootstrap.esm.min'
window.toast = toast;


async function fetchDataAndUpdateContent(event) {
    var awardId = event.target.getAttribute("data-award-id");
    var url = awardId ? `/awards/${awardId}/edit` : `/awards/new`;

    try {
        const response = await fetch(url, { method: "GET" });
        const html = await response.json();
        const element = document.getElementById("award-modal");
        
        element.innerHTML = html["partial"];

        let myModal = new Modal(document.getElementById('exampleModal'), { keyboard: false })
        myModal.show();
    } catch (error) {
        console.error('Ошибка при выполнении запроса:', error);
    }
}

var awardsModals = document.querySelectorAll(".awards-modal");

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

const avatarToggles = document.querySelectorAll('.avatar-toggle');
const targets = document.querySelectorAll('.target');

avatarToggles.forEach(avatarToggle => {
    avatarToggle.addEventListener('mouseenter', () => {
        avatarToggle.style.display = 'none';

        const id = avatarToggle.id;
        const target = document.getElementById(`target-${id}`);

        if (target) { target.style.display = 'block'; }
    });
});

targets.forEach(target => {
    target.addEventListener('mouseleave', () => {
        target.style.display = 'none';

        const targetId = target.id;

        const avatarToggle = document.querySelector(`.avatar-toggle[id="${targetId.split('-')[1]}"]`);

        if (avatarToggle) { avatarToggle.style.display = 'block'; }
    });
});
