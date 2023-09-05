<script lang='ts'>
    import Page from './Page.svelte';
    import Text from './Text.svelte';

    export let title: string = '';
    export let data: string[];
</script>

{#each data as _, i}
    <Page {title} classes="{i !== (data.length - 1) ? 'printonly' : ''}">
        <div class='content'>
            <ul>
                {#each data as line, j}
                    {#if j <= i}
                        <li><Text v='{line}' /></li>
                    {/if}
                {/each}
            </ul>
        </div>
    </Page>
{/each}