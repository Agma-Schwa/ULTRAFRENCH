<script lang='ts'>
    import Page from './Page.svelte';
    import {onMount} from 'svelte';

    export let classes = '';
    export let title = '';
    export let vcenter: boolean = true;

    let vcenter_el: HTMLDivElement;
    onMount(() => {
        /// If there is a title, exclude the height of the title from the vcenter height
        if (title.length > 0) {
            vcenter_el.style.setProperty('--vcenter-margin-top', 'calc(var(--h2-height) + var(--h2-padding-top))');
        }
    });

</script>

<style lang='scss'>
    div {
        --vcenter-margin-top: 1rem;
        height: 100%;
        width: 100%;
        display: flex;
        flex-direction: column;
        align-items: center;
        transform: translateY(calc(-1 * var(--vcenter-margin-top)));
    }

    .vcenter {
        justify-content: center;
    }

    div:not(.vcenter) {
        justify-content: flex-start;
        padding-top: var(--vcenter-margin-top);
        height: calc(100% - var(--vcenter-margin-top));
    }
</style>

<Page {classes} {title}>
    <div class="centred {vcenter ? 'vcenter' : ''}" bind:this={vcenter_el}>
        <slot/>
    </div>
</Page>