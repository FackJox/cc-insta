import { writable } from 'svelte/store';

export const currentView = writable('list'); // 'list' or 'conversation'
export const currentConversationId = writable(null);